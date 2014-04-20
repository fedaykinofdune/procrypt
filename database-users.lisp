(in-package :procrypt)

(defclass users ()
  ((name :accessor name
         :initarg :name
         :col-type text)
   (email :accessor email
          :initarg :email
          :col-type text)
   (password :accessor password
             :initarg :password
             :col-type text)
   (salt :accessor salt
         :initarg :salt
         :col-type text))
  (:keys email) 
  (:metaclass dao-class))

(deftable users
  (!dao-def))

(defun list-user-emails ()
  (with-connection *db*
    (query (:select 'email :from 'users) :column)))

(defun find-user-by-email (email)
  (with-connection *db*
    (query (:select '* :from 'users :where (:= 'email email)) :plist)))

(defun insert-user (user-name email password)
  (with-connection *db*
    (unless (find-user-by-email email)
      (let ((password-hash (hash-password password)))
        (insert-dao
          (make-instance 'users
                         :name user-name
                         :email email
                         :password (getf password-hash :hash)
                         :salt (getf password-hash :salt))))))) 

(defun insert-user-balances (user-email)
  (insert-balances user-email))

(defun update-user-email (user-email new-email)
  (with-connection *db*
    (unless (find-user-by-email user-email)
      (query (:update 'users :set 'email '$1
              :where (:= 'id user-email))
             new-email))))

(defun update-user-password (user-email password)
  (with-connection *db*
    (let ((password-hash (hash-password password)))
      (query (:update 'users :set 'password '$1 'salt '$2
              :where (:= 'id user-email))
             (getf password-hash :hash)
             (getf password-hash :salt)))))

(defun add-new-user (&key user-name email password)
  (insert-user user-name email password)
  (insert-user-balances email))
