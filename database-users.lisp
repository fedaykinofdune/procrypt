(in-package :procrypt)

(defclass users ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (name :accessor name
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
  (:keys id) 
  (:metaclass dao-class))

(deftable users
  (!dao-def))

(defun find-user-by-email (email)
  (with-connection *db*
    (query (:select '* :from 'users :where (:= 'email email)) :plist)))

(defun insert-user (&key user-name email password)
  (with-connection *db*
    (unless (find-user-by-email email)
      (let ((password-hash (hash-password password)))
        (insert-dao
          (make-instance 'users
                         :name user-name
                         :email email
                         :password (getf password-hash :hash)
                         :salt (getf password-hash :salt))))))) 
