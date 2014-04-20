(in-package :procrypt)

(defclass orders ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (timstamp :accessor timestamp
             :initarg :timestamp
             :initform (get-universal-time)
             :col-type bigint)
   (user :accessor user
         :initarg :user
         :col-type integer)
   (action :accessor action
           :initarg :action
           :col-type text)
   (trade-pair :accessor trade-pair
               :initarg :trade-pair
               :col-type text)
   (price :accessor price
          :initarg :price
          :col-type bigint)
   (quantity :accessor quantity
             :initarg :quantity
             :col-type double-precision))
  (:keys id)
  (:metaclass dao-class))

(deftable orders
  (!dao-def)
  (!foreign 'users 'user 'id)) 

(defun insert-order (&key user-id action trade-pair price quantity)
  (with-connection *db*
    (insert-dao
      (make-instance 'orders
                     :user user-id
                     :action action
                     :trade-pair trade-pair
                     :price price
                     :quantity quantity)))) 
