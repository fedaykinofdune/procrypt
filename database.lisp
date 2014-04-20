(in-package :procrypt)

(defparameter *db* '("procrypt" "axion" nil "localhost"))

(defclass users ()
  ((id :accessor user-id :initarg :id :col-type serial)
   (name :accessor user-name :initarg :name :col-type text)
   (email :accessor user-email :initarg :email :col-type text)
   (password :accessor user-password :initarg :password :col-type text)
   (salt :accessor user-salt :initarg :salt :col-type text))
  (:metaclass dao-class)
  (:keys id))

(defun create-tables ()
  (with-connection *db*
    (unless (table-exists-p 'users)
      (execute (dao-table-definition 'users))
      (execute (:create-unique-index 'user-email
                :on "users" :fields 'email)))))

(defun remove-table (table-name)
  (with-connection *db*
    (when (table-exists-p table-name)
      (query (:drop-table table-name))
      (format nil "Table removed: ~a" table-name))))

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
