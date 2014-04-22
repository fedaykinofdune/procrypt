(in-package :procrypt)

(defmacro generic-page ((&key title selected) &body body)
  "Generates the html which all pages have in common."
  `(<:html
     (<:head
       (<:title (format nil "~a » ~a" (title *config*) ,title))
       (<:meta :http-equiv "Content-Type" :content "text/html; charset=utf-8")
       (<:meta :name "author" :content
         (format nil "~a <~a>" (title *config*) (email *config*)))
       (<:link :rel "stylesheet" :type "text/css" :href "/site.css"))
     (<:body
       (<:div :id "header"
         (<:div :id "header-content"
           (<:div :id "title" (title *config*))
           (navigation-menu :selected ,selected)
           (<:div :id "header-right")))
       (<:div :id "wrapper" ,@body)
       (<:div :id "footer"
         "&copy;2014-" (nth-value 5 (get-decoded-time))
         " " (<:a :href (format nil "mailto:~a" (email *config*)) "Procrypt")))))

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
       ,(menu-item "/markets" "Markets"))))

(defmacro content-main ((&key title) &body body)
  "Generates the main section of the current page."
  `(<:div :id "main"
    (<:h1 ,title)
    ,@body))

(defun 404-page ()
  "The page displayed when a path on the web server cannot be found."
  (let ((title "Page Not Found"))
    (generic-page
      (:title title)
      (content-main
        (:title title)
        (<:p "The requested page was not found.")
        (<:p (<:a :href "/" "Go back"))))))
