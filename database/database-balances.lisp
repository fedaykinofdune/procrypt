(in-package :procrypt)

(defclass balances ()
  ((user-id :accessor user-id
            :initarg :user-id
            :col-type integer)
   (coin :accessor coin
         :initarg :coin
         :col-type text)
   (quantity :accessor quantity
             :initarg :quantity
             :col-default 0
             :col-type double-precision))
  (:keys user-id coin)
  (:metaclass dao-class))

(deftable balances
  (!dao-def)
  (!foreign 'users 'user-id 'id)
  (!foreign 'coins 'coin 'code))

(defun insert-balances (user-id)
  "Insert records for each coin into the balances table for the given
   user id."
  (with-connection *database*
    (dolist (coin-row (find-all-coins))
      (make-dao 'balances
                :user-id user-id
                :coin (code coin-row)))))

(defun find-user-balance (user-id coin-code)
  "Return an object representing the record from the balances table for
   the given user id and coin code."
  (with-connection *database*
    (first
      (select-dao
        'balances (:and
                    (:= 'user-id user-id)
                    (:= 'coin coin-code))))))

(defun find-all-user-balances (user-id)
  "Return a list of objects representing records from the balances table
   of each coin for the given user id."
  (with-connection *database*
    (select-dao
      'balances (:= 'user-id user-id)
      'coin)))

(defun find-positive-user-balances (user-id)
  "Return a list of objects representing records from the balances table
   of each coin with a positive balance for the given user id."
  (with-connection *database*
    (select-dao
      'balances (:and
                  (:= 'user-id user-id)
                  (:> 'quantity 0))
      'coin)))
