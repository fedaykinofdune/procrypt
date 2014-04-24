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
         (<:div :id "header-content"
           (<:div :id "title" (title *config*)))
           (navigation-menu :selected ,selected))
       ,@body
       (<:div :id "footer"
         (format nil "&copy;2014-~a ~a"
                 (nth-value 5 (get-decoded-time))
                 (<:a :href (format nil "mailto:~a" (email *config*))
                      "Procrypt"))))))

(defmacro navigation-menu (&key (selected ""))
  "Generates the navigation menu with the current page highlighted."
  (flet ((menu-item (path title)
    `(<:li
       ,@(when (string= title selected)
           (list :class "selected"))
       (<:a :href ,path ,title))))
     `(<:ul :id "menu"
       ,(menu-item "/overview" "Overview")
       ,(menu-item "/wallets" "Wallets")
       ,(menu-item "/markets" "Markets")
       ,(menu-item "/account" "Account"))))

(defmacro content (&body body)
  "Generates the main section of the current page."
  `(<:div :id "wrapper"
    (<:div :id "sidebar"
      (sidebar))
    (<:div :id "main"
      ,@body)))

(defun sidebar ()
  (<:div :id "sidebar-content"
    (<:h1 "Markets")
    (<:table
      (<:tr
        (<:td "Coin")
        (<:td "Price")
        )
    ))
  )

(defun 404-page ()
  "The page displayed when a path on the web server cannot be found."
  (let ((title "Page Not Found"))
    (generic-page
      (:title title)
      (content-main
        (:title title)
        (<:p "The requested page was not found.")
        (<:p (<:a :href "/" "Go back"))))))
