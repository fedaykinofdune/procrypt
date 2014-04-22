(in-package :procrypt)

(defclass config ()
  ((title :reader title
          :initarg :title)
   (subtitle :reader subtitle
             :initarg :subtitle)
   (email :reader email
          :initarg :email)
   (port :accessor port
         :initarg :port
         :initform 8080)
   (root :reader root
         :initarg :root
         :initform "static/")
   (modules :reader modules
            :initarg :modules
            :initform '())
   (routes :reader routes
           :initarg :routes
           :initform '())))

(defparameter *config*
  (make-instance 'config
                 :title "Procrypt"
                 :subtitle "Some tagline"
                 :email "procrypt@example.com"
                 :port 12345
                 :root "static/"
                 :modules '(module-admin "/admin")
                 :routes '(404 "/404"
                           home "/"
                           site-style "/site.css")))
