(defsystem procrypt
  :name "procrypt"
  :author "axion <axedcode@gmail.com>"
  :description "Procrypt"
  :depends-on (:axion.utils
               :postmodern
               :hunchentoot
               :sexml
               :css-lite)
  :serial t
  :components ((:file "packages")
               (:file "rpc-client")
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
                    (:file "documents")
                    (:file "style")
                    (:module "modules"
                      :components
                        ((:file "overview")
                         (:file "trade")
                         (:file "account")
                         (:file "admin")))))))
