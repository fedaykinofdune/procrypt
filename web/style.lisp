(in-package :procrypt)

(defun site-style ()
  "Generates the stylesheet for the web site."
  (setf (content-type* *reply*) "text/css")
  (css
    (("body")
     (:margin 0
      :padding 0
      :font "12pt Ubuntu"
      :background-color "#eee"
      :color "#444"))
    (("a")
     (:text-decoration "none"
      :color "#38a5ff"))
    (("#header")
     (:padding-top "1em"
      :height "3em"
      :background-color "#444"))
    (("#header-content")
     (:white-space "nowrap"
      :display "flex"))
    (("#title")
     (:color "#38a5ff"
      :font-size "20pt"
      :display "inline-block"
      :margin "0 2em 0 1em"))
    (("#title span")
     (:color "#fa7000"))
    (("#menu")
     (:margin 0
      :padding 0
      :display "inline-block"))
    (("#menu li")
     (:display "inline-block"
      :list-style "none"
      :text-align "center"
      :padding "0.5em 1em"))
    (("#menu li a")
     (:color "#eee"))
    (("#menu li a:hover")
     (:color "#38a5ff"))
    (("#menu li.selected")
     (:background-color "#38a5ff"
      :border-radius "0.5em"))
    (("#menu li.selected a")
     (:color "#eee"))
    (("#menu #login")
     (:position "absolute"
      :top 0
      :right 0
      :padding "1em 1em 0 0")) 
    (("#main")
     (
      ))
    (("#footer")
     (:padding "1em 0 1em 0"
      :font-size "8pt"
      :font-size "8pt"
      :line-height "1em"
      :text-align "center"
      :color "#eee"
      :background-color "#444"
      :border-top "1px solid #ddd"))))
