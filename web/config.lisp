(in-package :procrypt)

(defparameter *web-config*
  (make-instance 'web-config
                 :title "ProCrypt"
                 :subtitle "Some tagline"
                 :email "procrypt@example.com"
                 :version "0.1"
                 :port 12345
                 :root "static/"
                 :modules '(module-overview "/overview"
                            module-trade "/trade"
                            module-account "/account")
                 :routes '(404 "/404"
                           home "/"
                           site-style "/site.css")))
