(in-package :procrypt)

(defparameter *db* '("procrypt" "axion" nil "localhost"))
(defparameter *table-names*
  '(users
    coins
    balances
    orders))

(defun create-tables ()
  (with-connection *db*
    (dolist
      (table-name *table-names*)
      (unless (table-exists-p table-name)
        (create-table table-name)))))

(defun remove-table (table-name &key (cascade nil))
  (with-connection *db*
    (when (table-exists-p table-name)
      (if cascade
        (execute (:cascade (:drop-table table-name)))
        (execute (:drop-table table-name)))
      (format nil "Removed table: ~a" table-name))))

(defun remove-all-tables ()
  (with-connection *db*
    (dolist
      (table-name *table-names*)
      (remove-table table-name :cascade t)))
  "Removed all tables")
