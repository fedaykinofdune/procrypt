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
         :col-type integer))
  (:keys code)
  (:metaclass dao-class))

(deftable coins
  (!dao-def))

(defun find-coin-by-code (code)
  (with-connection *db*
    (query (:select '* :from 'coins :where (:= 'code code)) :plist)))

(defun insert-coin (code name address port)
  (with-connection *db*
    (unless (find-coin-by-code code)
      (insert-dao
        (make-instance 'coins
                       :code code
                       :name name
                       :address address
                       :port port)))))

(defun insert-coin-balances (coin-code)
  (with-connection *db*
    (dolist (user-email (list-user-emails))
      (insert-dao
        (make-instance 'balances
                       :user user-email
                       :coin coin-code)))))

(defun list-coin-codes ()
  (with-connection *db*
    (query (:select 'code :from 'coins) :column)))

(defun add-new-coin (&key code name address port)
  (insert-coin code name address port)
  (insert-coin-balances code))
