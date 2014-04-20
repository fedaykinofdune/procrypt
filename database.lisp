(in-package :procrypt)

(defparameter *db* '("procrypt" "axion" nil "localhost"))

(defun create-tables ()
  (with-connection *db*
    (dolist
      (table '(users
               coins
               balances
               orders))
      (unless (table-exists-p table)
        (create-table table)))))

(defun remove-table (table-name)
  (with-connection *db*
    (when (table-exists-p table-name)
      (query (:drop-table table-name))
      (format nil "Removed table: ~a" table-name))))
