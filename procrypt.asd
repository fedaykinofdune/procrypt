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
               (:file "database-users")
               (:file "database-coins")
               (:file "database-balances")
               (:file "database-orders")
               (:file "database-trades")
               (:file "main")))
