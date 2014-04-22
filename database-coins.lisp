(in-package :procrypt)

(defclass coins ()
  ((code :accessor code
         :initarg :code
         :col-type text)
   (name :accessor name
         :initarg :name
         :col-type text)
   (trade-fee :accessor trade-fee
              :initarg :trade-fee
              :col-type real
              :col-default 0.2)
   (address :accessor address
            :initarg :address
            :col-type text)
   (port :accessor port
         :initarg :port
         :col-type integer))
  (:keys code)
  (:metaclass dao-class))

(deftable coins
  (!dao-def))

(defun add-new-coin (&key code name address port (trade-fee 0.2))
  "Top-level function responsible for adding a new record to the coins table,
   and adding records for the balance of that coin for each user to the
   balances table."
  (insert-coin code name address port trade-fee)
  (insert-coin-balances code))

(defun insert-coin (code name address port trade-fee)
  "Insert a record into the coins table."
  (with-connection *db*
    (unless (find-coin-by-code code)
      (make-dao 'coins
                :code code
                :name name
                :trade-fee trade-fee
                :address address
                :port port))))

(defun insert-coin-balances (coin-code)
  "Insert a record for the given coin into the balances table for all users."
  (with-connection *db*
    (dolist (user-row (find-all-users))
      (make-dao 'balances
                :user-id (id user-row)
                :coin coin-code))))

(defun find-coin-by-code (coin-code)
  "Returns an object representing a record in the coins table with the given
   coin code."
  (with-connection *db*
    (get-dao 'coins coin-code)))

(defun find-all-coins ()
  "Returns a list of objects representing all records in the coins table,
   sorted by coin code."
  (with-connection *db*
    (query-dao 'coins
               (:order-by
                 (:select '* :from 'coins)
                 'code))))
