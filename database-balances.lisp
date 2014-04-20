(in-package :procrypt)

(defclass balances ()
  ((user :accessor user
         :initarg :user
         :col-type integer) 
   (coin :accessor coin
         :initarg :coin
         :col-type integer)
   (quantity :accessor quantity
             :initarg :quantity
             :col-type double-precision))
  (:keys user coin)
  (:metaclass dao-class))

(deftable balances
  (!dao-def)
  (!foreign 'users 'user 'id)
  (!foreign 'coins 'coin 'id))
