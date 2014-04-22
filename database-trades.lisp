(in-package :procrypt)

(defclass trades ()
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

(deftable trades
  (!dao-def)
  (!foreign 'users 'user-id 'id)
  (!foreign 'coins 'base-coin 'code)
  (!foreign 'coins 'quote-coin 'code))

(defun insert-trade (order-id)
  "Inserts an order record into the trades table, and sets its timestamp
   to the current time."
  (with-connection *db*
    (unless (get-dao 'trades order-id)
      (query (:insert-into 'trades
              (:select '* :from 'orders
               :where (:= 'id order-id))))
      (let ((trade-row (get-dao 'trades order-id)))
        (setf (timestamp trade-row) (get-universal-time))
        (update-dao trade-row)))))

(defun find-user-trades (user-id)
  "Return a list of objects representing trade records for the given user id,
   sorted by the time they were traded."
  (with-connection *db*
    (select-dao 'trades (:= 'user-id user-id) 'timestamp)))
