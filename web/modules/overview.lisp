(in-package :procrypt)

(defclass module-overview ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(overview ""))))

(defun overview ()
  "The main overview section of the web site."
  (generic-page
    (:title "Overview"
     :selected "Overview")
    (content
      "content"
      )))
