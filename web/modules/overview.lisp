(in-package :procrypt)

(defclass module-overview ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(overview ""))))

(defun overview ()
  (let ((title "Home"))
    (generic-page
      (:title title
       :selected "home")
      (content-main
        (:title title)
        "Test"
        ))))
