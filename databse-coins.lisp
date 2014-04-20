(in-package :procrypt)

(defclass coins ()
  ((id :accessor id
       :initarg :id
       :col-type serial)
   (code :accessor code
         :initarg :code
         :col-type text)
   (name :accessor name
         :initarg :name
         :col-type text))
  (:keys id)
  (:metaclass dao-class))

(deftable coins
  (!dao-def)) 
