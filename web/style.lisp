(in-package :procrypt)

(defun site-style ()
  "Generates the stylesheet for the web site."
  (setf (content-type* *reply*) "text/css")
  (css
    (("#html")
     (:height "100%"))
    (("body")
     (:margin 0
      :padding 0
      :height "100%"
      :font "12pt Ubuntu"
      :background-color "#eee"
      :color "#444"))
    (("a")
     (:text-decoration "none"
      :color "#38a5ff"))
    (("#wrapper")
     (:min-height "100%"
      :position "relative"))
    (("#content")
     (:margin-top "30px"
      :padding-top "2em"))

    ;; generic classes
    ((".left")
     (:float "left"))
    ((".right")
     (:float "right"))
    ((".no-select")
     (:user-select "none"
      :-moz-user-select "none"
      :-webkit-user-select "none"
      :-khtml-user-select "none"
      :-o-user-select "none"
      :user-select "none"))

    ;; header
    (("#header")
     (:padding "1em 0"
      :position "fixed"
      :top 0
      :z-index "10"
      :width "100%"
      :height "30px"
      :background-color "#444"))
    (("#header-content")
     (:width "21em"))
    (("#title")
     (:color "#38a5ff"
      :cursor "default"
      :font "italic bold 24pt Exo"
      :line-height "30px"
      :text-align "center"))
    (("#title span")
     (:color "#eee"))
    (("#menu")
     (:margin 0
      :padding 0))
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

    ;; sidebar
    (("#sidebar")
     (:width "20em"
      :height "100%"
      :color "#444"
      :text-align "center"))
    (("#sidebar-content")
     (:padding "1em 1em 3em 1em"
      :min-height "100%"
      :border-right "1px solid #aaa"))
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
     (:padding "1em 1em"))

    ;; footer
    (("#footer")
     (:padding "1em 0"
      :position "fixed"
      :width "100%"
      :height "1em"
      :bottom 0
      :font "8pt monospace"
      :line-height "1em"
      :text-align "center"
      :color "#eee"
      :background-color "#444"))))
