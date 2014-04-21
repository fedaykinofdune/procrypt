(in-package :procrypt)

(defparameter *db* '("procrypt" "axion" nil "localhost"))

(defparameter *table-names*
  '(users
    coins
    balances
    orders
    trades))

(defun create-tables ()
  "Create all defined tables of the database if they do not already exist."
  (with-connection *db*
    (dolist
      (table-name *table-names*)
      (unless (table-exists-p table-name)
        (create-table table-name)))))

(defun remove-table (table-name &key (cascade nil))
  "Remove the given table from the database."
  (with-connection *db*
    (when (table-exists-p table-name)
      (if cascade
        (execute (:cascade (:drop-table table-name)))
        (execute (:drop-table table-name)))
      (format nil "Removed table: ~a" table-name))))

(defun remove-all-tables ()
  "Remove all tables from the database."
  (with-connection *db*
    (dolist
      (table-name *table-names*)
      (remove-table table-name :cascade t)))
  "Removed all tables")
