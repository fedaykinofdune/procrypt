(in-package :procrypt)

(defmacro generic-page ((&key title selected) &body body)
  "Generates the html which all pages have in common."
  `(<:html
     (<:head
       (<:title (format nil "~a » ~a" (title *config*) ,title))
       (<:meta :http-equiv "Content-Type" :content "text/html; charset=utf-8")
       (<:meta :name "author" :content
         (format nil "~a <~a>" (title *config*) (email *config*)))
       (<:link :rel "stylesheet" :type "text/css" :href "/site.css")
       (<:link :rel "stylesheet" :type "text/css"
               :href "http://fonts.googleapis.com/css?family=Ubuntu")
       (<:link :rel "stylesheet" :type "text/css"
               :href "http://fonts.googleapis.com/css?family=Exo:800italic"))
     (<:body
       (<:div :id "header"
         (<:div :id "header-content" :class "left"
           (<:div :id "title" :class "no-select"
             (<:a :href "/" (<:span "Pro") "Crypt")))
           (navigation-menu :selected ,selected))  
       (<:div :id "content"
         (<:div :id "sidebar" :class "left" (sidebar))
         (<:div :id "main"
           (<:div :id "main-content" ,@body)))
       (<:div :id "footer"
         (format nil "&copy;2014-~a ~a"
                 (nth-value 5 (get-decoded-time))
                 (<:a :href (format nil "mailto:~a" (email *config*))
                      "ProCrypt"))))))

(defmacro navigation-menu (&key (selected ""))
  "Generates the navigation menu with the current page highlighted."
  (flet ((menu-item (path title)
    `(<:li
       ,@(when (string= title selected)
           (list :class "selected"))
       (<:a :href ,path ,title))))
    `(list
       (<:ul :id "menu" :class "left"
         ,(menu-item "/overview" "Overview")
         ,(menu-item "/trade" "Trade")
         ,(menu-item "/wallets" "Wallets")
         ,(menu-item "/help" "Help")
         ,(menu-item "/account" "Account"))
       (<:ul :id "menu" :class "right"
         ,(menu-item "/login" "Login")
         ,(menu-item "/signup" "Sign Up")))))

(defun sidebar-prices (base-coin)
  (loop for coin in (find-coins-by-base base-coin)
        for code = (code coin)
        for last-trade = (car (find-market-trades base-coin code :limit 1))
        for price = (satoshi->string (if last-trade (price last-trade) 0))
        collect (<:tr (<:td code) (<:td price))))

(defun sidebar ()
  (<:div :id "sidebar-content"
    (<:h1 "Bitcoin Markets")
    (<:table
      (<:tr
        (<:td "Coin")
        (<:td "Price"))
      (sidebar-prices "BTC"))
    
    (<:h1 "Litecoin Markets")
    (<:table
      (<:tr
        (<:td "Coin")
        (<:td "Price"))
      (sidebar-prices "LTC"))))

(defun 404-page ()
  "The page displayed when a path on the web server cannot be found."
  (generic-page
    (:title "Page Not Found")
    (<:h1 "Page Not Found")
    (<:p "The requested page was not found.")
    (<:p (<:a :href "/" "Go back"))))
