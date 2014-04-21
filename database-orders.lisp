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
             :col-type double-precision)
   (closed :accessor closed
           :initarg :closed
           :col-type boolean
           :col-default nil))
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

(defun update-order-closed (order-id)
  "Updates the record of the given order id as closed."
  (with-connection *db*
    (let ((order-row (get-dao 'orders order-id)))
      (when order-row
        (setf (closed order-row) t)
        (update-dao order-row)))))

(defun remove-order (order-id)
  "Removes the record of the given order id from the orders table."
  (with-connection *db*
    (let ((order-row (get-dao 'orders order-id)))
      (when order-row
        (delete-dao order-row)))))

(defun find-all-open-orders ()
  "Returns a list of objects representing all open orders in the orders table,
   sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:= 'closed nil)
                'timestamp)))

(defun find-all-closed-orders ()
  "Returns a list of objects representing all closed orders in the orders
   table, sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:= 'closed t)
                'timestamp)))

(defun find-user-open-orders (user-id)
  "Returns a list of objects representing all open orders in the orders
   table for the given user id, sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:and
                          (:= 'closed nil)
                          (:= 'user-id user-id))
                'timestamp)))

(defun find-user-closed-orders (user-id)
  "Returns a list of objects representing all closed orders in the orders
   table for the given user id, sorted by the time they were placed."
  (with-connection *db*
    (select-dao 'orders (:and
                          (:= 'closed t)
                          (:= 'user-id user-id))
                'timestamp)))
