(defsystem procrypt
  :name "procrypt"
  :author "axion <axedcode@gmail.com>"
  :description "Procrypt"
  :depends-on (:postmodern
               :cl-fad
               :ironclad
               :babel)
  :serial t
  :components ((:file "packages")
               (:file "utils")
               (:file "database")
               (:file "main")))
