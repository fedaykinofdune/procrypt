(in-package :procrypt)

(defclass users ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (name :accessor name
         :initarg :name
         :col-type text)
   (password :accessor password
             :initarg :password
             :col-type text) 
   (email :accessor email
          :initarg :email
          :col-type text)
   (salt :accessor salt
         :initarg :salt
         :col-type text))
  (:keys id)
  (:metaclass dao-class))

(deftable users
  (!dao-def))

(defun add-new-user (&key username password email)
  "Top-level function responsible for adding a new record to the users
   table, and all the coin balance records to the balances table."
  (let ((user-id (insert-user username password email)))
    (when user-id
      (insert-balances user-id))))

(defun insert-user (username password email)
  "Insert a new user record into the users table returning its user id."
  (with-connection *database*
    (unless (find-user-by-email email)
      (let ((password-hash (hash-password password)))
        (make-dao 'users
                  :name username
                  :email email
                  :password (getf password-hash :hash)
                  :salt (getf password-hash :salt))
        (id (find-user-by-email email))))))

(defun find-all-users ()
  "Returns a list of all user row objects."
  (with-connection *database*
    (select-dao 'users)))

(defun find-user-by-email (user-email)
  "Returns an object representing the record in the users table with the
   given email."
  (with-connection *database*
    (first (select-dao 'users (:= 'email user-email)))))

(defun update-user-email (user-email new-email)
  "Updates the user record for the given email address with a new email
   address."
  (with-connection *database*
    (let* ((user-row (find-user-by-email user-email)))
      (when user-row
        (setf (email user-row) new-email)
        (update-dao user-row)))))

(defun update-user-password (user-email password)
  "Updates the user record for the given email address with a new password."
  (with-connection *database*
    (let* ((user-row (find-user-by-email user-email))
           (password-hash (hash-password password))
           (hash (getf password-hash :hash))
           (salt (getf password-hash :salt)))
      (when user-row
        (setf (password user-row) hash)
        (setf (salt user-row) salt)
        (update-dao user-row)))))
