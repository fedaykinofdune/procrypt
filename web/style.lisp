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
     (:padding "0.5em 0 0.5em 0"
      :background-color "#444"))
    (("#header-content")
     (:width "22em"
      :display "inline-block"
      :vertical-align "middle"
      ))
    (("#title")
     (:color "#38a5ff"
      :font "24pt Exo"
      :font-weight "bold"
      :font-style "italic"
      :text-align "center"))
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
    (("#wrapper")
     (:margin-top "2em"))
    (("#sidebar")
     (:width "20em"
      :float "left"
      :color "#444"
      :padding-bottom "2em"
      :text-align "center"))
    (("#sidebar h1")
     (:margin "0 0 1em 0"
      :font-size "14pt"))
    (("#sidebar table")
     (:width "100%"
      :border "1px solid #ddd"
      :font-size "10pt"
      ))
    (("#sidebar table td")
     (:padding "0.5em"))
    (("#sidebar-content")
     (:padding "0 1em"))
    (("#main")
     (:padding "0 22em")
     )
    (("#footer")
     (:padding "1em 0 1em 0"
      :font-size "8pt"
      :font-size "8pt"
      :line-height "1em"
      :text-align "center"
      :color "#eee"
      :clear "both"
      :background-color "#444"
      :border-top "1px solid #ddd"))))
