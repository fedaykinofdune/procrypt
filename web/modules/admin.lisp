(in-package :procrypt)

(defclass module-admin ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(admin ""))))

(defun admin ())
