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

    ;; header
    (("#header")
     (:padding "1em 0"
      :position "fixed"
      :top 0
      :width "100%"
      :height "30px"
      :background-color "#444"))
    (("#header-content")
     (:width "21em"
      :float "left"))
    (("#title")
     (:color "#38a5ff"
      :font "24pt Exo"
      :line-height "30px"
      :font-weight "bold"
      :font-style "italic"
      :text-align "center"))

    ;; menu
    (("#menu")
     (:margin 0
      :padding 0
      :float "left"))
    (("#menu li")
     (:display "inline-block"
      :list-style "none"
      :line-height "30px"
      :padding "0 1em"))
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
     (:margin-top "3em"))

    ;; sidebar
    (("#sidebar")
     (:width "20em"
      :float "left"
      :color "#444"
      :padding "2em 0"
      :text-align "center"
      :border-right "1px solid #aaa"))
    (("#sidebar-content")
     (:padding "0 1em"
      :height "100%")) 
    (("#sidebar h1")
     (:margin "0 0 1em 0"
      :font-size "14pt"))
    (("#sidebar table")
     (:width "100%"
      :border "1px solid #ddd"
      :font-size "10pt"))
    (("#sidebar table td")
     (:padding "0.5em"))

    ;; main
    (("#main")
     (:padding "2em 21em"))

    ;; footer
    (("#footer")
     (:padding "1em 0 1em 0"
      :position "fixed"
      :bottom 0
      :width "100%"
      :font-size "8pt"
      :font-size "8pt"
      :line-height "1em"
      :text-align "center"
      :color "#eee"
      :clear "both"
      :background-color "#444"))))
