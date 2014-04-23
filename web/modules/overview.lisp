(in-package :procrypt)

(defclass module-overview ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(overview ""))))

(defun overview ()
  "The main overview section of the web site."
  (let ((title "Overview"))
    (generic-page
      (:title title
       :selected "Overview")
      (content-main
        (:title title)
        "Test"
        ))))
