(in-package :procrypt)

(defclass balances ()
  ((user :accessor user
         :initarg :user
         :col-type text) 
   (coin :accessor coin
         :initarg :coin
         :col-type text)
   (quantity :accessor quantity
             :initarg :quantity
             :col-default 0
             :col-type double-precision))
  (:keys user coin)
  (:metaclass dao-class))

(deftable balances
  (!dao-def)
  (!foreign 'users 'user 'email)
  (!foreign 'coins 'coin 'code))

(defun insert-balances (user-email)
  (with-connection *db*
    (dolist (coin-code (list-coin-codes))
      (insert-dao
        (make-instance 'balances
                       :user user-email
                       :coin coin-code)))))

(defun find-user-balance (user-email coin-code)
  (with-connection *db*
    (query
      (:select 'quantity
       :from 'balances
       :where (:and
                (:= 'user user-email)
                (:= 'coin coin-code))) :single)))

(defun list-all-user-balances (user-email)
  (with-connection *db*
    (query
      (:order-by
        (:select 'coin 'quantity
         :from 'balances
         :where (:= 'user user-email))
        'coin))))

(defun list-positive-user-balances (user-email)
  (with-connection *db*
    (query
      (:order-by
        (:select 'coin 'quantity
         :from 'balances
         :where (:and
                  (:= 'user user-email)
                  (:> 'quantity 0))) 'coin))))
