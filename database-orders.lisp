(in-package :procrypt)

(defclass orders ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (timestamp :accessor timestamp
              :initarg :timestamp
              :col-type bigint)
   (user-id :accessor user-id
            :initarg :user-id
            :col-type integer)
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
             :col-type double-precision))
  (:keys id)
  (:metaclass dao-class))

(deftable orders
  (!dao-def)
  (!foreign 'users 'user-id 'id)
  (!foreign 'coins 'base-coin 'code)
  (!foreign 'coins 'quote-coin 'code))

(defun insert-order (&key user-id action base-coin quote-coin price
                          quantity)
  "Insert a record into the orders table."
  (with-connection *db*
    (make-dao 'orders
              :user-id user-id
              :timestamp (get-universal-time)
              :action action
              :base-coin base-coin
              :quote-coin quote-coin
              :price price
              :quantity quantity)))

(defun update-order-complete (order-id)
  "Updates an order as having been completed by copying the record to the
   trades table and setting a new timestamp, then removing it from the orders
   table."
  (with-connection *db*
    (let ((order-row (get-dao 'orders order-id)))
      (when order-row
        (insert-trade order-id)
        (delete-dao order-row)))))

(defun remove-order (order-id)
  "Removes the record of the given order id from the orders table."
  (with-connection *db*
    (let ((order-row (get-dao 'orders order-id)))
      (when order-row
        (delete-dao order-row)))))

(defun find-all-orders ()
  "Returns a list of objects representing all orders in the orders table,
   sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:= 'closed nil)
                'timestamp)))

(defun find-user-orders (user-id)
  "Returns a list of objects representing all orders in the orders
   table for the given user id, sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:and
                          (:= 'closed nil)
                          (:= 'user-id user-id))
                'timestamp)))
