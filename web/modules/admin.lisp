(in-package :procrypt)

(defclass module-admin ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(page-admin ""
                       page-add-coin "/add-coin"
                             ))))

(defun page-admin ()
  (let ((title "Admin"))
    (generic-page
      (:title title
       :selected "Admin")
      (content-main
        (:title title)
        (<:form :action "/admin/add-coin" :method "post"
          (<:p "Add Coin")
          "Code " (<:input :type "text" :name "code") (<:br)
          "Name " (<:input :type "text" :name "name") (<:br)
          "Fee " (<:input :type "text" :name "trade-fee" :value "0.2") "%" (<:br) 
          "Daemon Address " (<:input :type "text" :name "address") (<:br)
          "Daemon Port " (<:input :type "text" :name "port") (<:br)
          "Daemon User " (<:input :type "text" :name "username") (<:br)
          "Daemon Password " (<:input :type "text" :name "password") (<:br)
          (<:input :type "submit" :value "Add"))
        (<:p "All Coins")
        (loop for coin in (find-all-coins)
              collect (nconc (list (name coin) (<:br)))
              )
        ))))

(defun page-add-coin ()
  (let ((code (parameter "code"))
        (name (parameter "name"))
        (trade-fee (parameter "trade-fee"))
        (address (parameter "address"))
        (port (parameter "port"))
        (username (parameter "username"))
        (password (parameter "password")))
    (add-new-coin :code code
                  :name name
                  :address address
                  :port port
                  :username username
                  :password password
                  :trade-fee trade-fee)
    (redirect "/admin")))
