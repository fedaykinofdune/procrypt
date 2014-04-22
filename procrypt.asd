(defsystem procrypt
  :name "procrypt"
  :author "axion <axedcode@gmail.com>"
  :description "Procrypt"
  :depends-on (:postmodern
               :hunchentoot
               :sexml
               :cl-fad
               :ironclad
               :babel)
  :serial t
  :components ((:file "packages")
               (:file "utils")
               (:file "main")
               (:module "database"
                 :components
                   ((:file "database")
                    (:file "database-users")
                    (:file "database-coins")
                    (:file "database-balances")
                    (:file "database-orders")
                    (:file "database-trades")))
               (:module "web"
                 :components
                   ((:file "config")
                    (:file "server")
                    (:module "modules"
                      :components
                        ((:file "admin")))))))
