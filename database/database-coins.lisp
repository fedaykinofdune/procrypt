(in-package :procrypt)

(defclass coins ()
  ((code :accessor code
         :initarg :code
         :col-type text)
   (name :accessor name
         :initarg :name
         :col-type text)
   (address :accessor address
            :initarg :address
            :col-type text)
   (port :accessor port
         :initarg :port
         :col-type integer)
   (username :accessor username
             :initarg :username
             :col-type text)
   (password :accessor password
             :initarg :password
             :col-type text)
   (trade-btc :accessor trade-btc
              :initarg :trade-btc
              :col-type boolean)
   (trade-ltc :accessor trade-ltc
              :initarg :trade-ltc
              :col-type boolean)
   (trade-fee :accessor trade-fee
              :initarg :trade-fee
              :col-type real))
  (:keys code)
  (:metaclass dao-class))

(deftable coins
  (!dao-def))

(defun add-new-coin (&key code name address port username password
                          trade-btc trade-ltc trade-fee)
  "Top-level function responsible for adding a new record to the coins table,
   and adding records for the balance of that coin for each user to the
   balances table."
  (insert-coin code name address port username password
               trade-btc trade-ltc trade-fee)
  (insert-coin-balances code))

(defun insert-coin (code name address port username password
                         trade-btc trade-ltc trade-fee)
  "Insert a record into the coins table."
  (with-connection *database*
    (unless (find-coin-by-code code)
      (make-dao 'coins
                :code code
                :name name
                :address address
                :port port
                :username username
                :password password
                :trade-btc trade-btc
                :trade-ltc trade-ltc
                :trade-fee trade-fee))))

(defun remove-coin (coin-code)
  "Removes a coin from the coins table."
  (with-connection *database*
    (let ((coin-row (get-dao 'coins coin-code)))
      (when coin-row
        (delete-dao coin-row)))))

(defun insert-coin-balances (coin-code)
  "Insert a record for the given coin into the balances table for all users."
  (with-connection *database*
    (dolist (user-row (find-all-users))
      (make-dao 'balances
                :user-id (id user-row)
                :coin coin-code))))

(defun find-coin-by-code (coin-code)
  "Returns an object representing a record in the coins table with the given
   coin code."
  (with-connection *database*
    (get-dao 'coins coin-code)))

(defun find-all-coins ()
  "Returns a list of objects representing all records in the coins table,
   sorted by coin code."
  (with-connection *database*
    (query-dao 'coins
               (:order-by
                 (:select '* :from 'coins)
                 'code))))

(defun find-coins-by-base (base-coin-code)
  "Returns a list of objects representing records in the coins table
   that are marked as able to be traded for the given base coin code,
   sorted by coin code."
  (with-connection *database*
    (cond
      ((string= base-coin-code "BTC")
       (query-dao 'coins
                  (:order-by
                    (:select '* :from 'coins
                     :where (:= 'trade-btc t))
                    'code)))
      ((string= base-coin-code "LTC")
       (query-dao 'coins
                  (:order-by
                    (:select '* :from 'coins
                     :where (:= 'trade-ltc t))
                    'code))))))
