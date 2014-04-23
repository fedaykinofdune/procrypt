(in-package :procrypt)

(defclass module-account ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(page-account ""))))

(defun page-account ()
  "The main user account page."
  (let ((title "Account"))
    (generic-page
      (:title title
       :selected "Account")
      (content-main
        (:title title)
        "User Details"
        )
      )))
