(in-package :procrypt)

(defclass orders ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (timestamp :accessor timestamp
              :initarg :timestamp
              :col-type bigint)
   (user :accessor user
         :initarg :user
         :col-type text)
   (action :accessor action
           :initarg :action
           :col-type text)
   (base-coin :accessor base-coin
              :initarg :base-coin
              :col-type text)
   (quote-coin :accessor quote-coin
               :initarg :quote-coin
               :col-type text)
   (price :accessor price
          :initarg :price
          :col-type bigint)
   (quantity :accessor quantity
             :initarg :quantity
             :col-type double-precision)
   (closed :accessor closed
           :initarg :closed
           :col-type boolean
           :col-default nil))
  (:keys id)
  (:metaclass dao-class))

(deftable orders
  (!dao-def)
  (!foreign 'users 'user 'email)
  (!foreign 'coins 'base-coin 'code)
  (!foreign 'coins 'quote-coin 'code))

(defun insert-order (&key user-email action base-coin quote-coin price
                          quantity)
  (with-connection *db*
    (insert-dao
      (make-instance 'orders
                     :user user-email
                     :timestamp (get-universal-time)
                     :action action
                     :base-coin base-coin
                     :quote-coin quote-coin
                     :price price
                     :quantity quantity)))) 

(defun edit-order-as-closed (order-id)
  (with-connection *db*
    (query
      (:update 'orders :set 'closed '$1
       :where (:= 'id order-id))
      t)))

(defun remove-order (order-id)
  (with-connection *db*
    (query
      (:delete-from 'orders :where (:= 'id order-id)))))

(defun list-open-orders-by-time ()
  (with-connection *db*
    (query
      (:order-by
        (:select '* :from 'orders
         :where (:= 'closed nil))
        'timestamp)
      :plists)))

(defun list-closed-orders-by-time ()
  (with-connection *db*
    (query
      (:order-by
        (:select '* :from 'orders
         :where (:= 'closed t))
        'timestamp)
      :plists)))

(defun list-user-open-orders (user-email)
  (with-connection *db*
    (query
      (:order-by
        (:select '* :from 'orders
         :where (:and
                  (:= 'closed nil)
                  (:= 'user user-email)))
        'timestamp)
      :plists)))

(defun list-user-closed-orders (user-email)
  (with-connection *db*
    (query
      (:order-by
        (:select '* :from 'orders
         :where (:and
                  (:= 'closed t)
                  (:= 'user user-email)))
        'timestamp)
      :plists)))
