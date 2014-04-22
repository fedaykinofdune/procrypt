(in-package :procrypt)

(defun site-style ()
  (setf (content-type* *reply*) "text/css")
  (css
    (("body")
     (:margin 0
      :padding 0
      :font-size "12pt"
      :background-color "#444"
      :color "#444"))
    (("a")
     (:text-decoration "none"
      :color "#38a5ff"))
    (("#header")
     (:margin "0 auto"
      :width "80%"
      :padding "0.5em 0"
      :background-color "#eee"
      :border-bottom "1px solid #ddd"
      :position "fixed"
      :top 0
      :left 0
      :right 0))
    (("#header-content")
     (:white-space "nowrap"
      :margin "0 1em"))
    (("#header-right")
     (:float "right"
      :position "absolute"
      :top "0.25em"
      :right "1em"
      :font-size "10pt"))
    ((".header-right-text")
     (:color "#38a5ff"
      :font-weight "bold"
      :letter-spacing "0.05em"
      :display "inline"))
    (("#title")
     (:color "#38a5ff"
      :font-size "18pt"
      :display "inline-block"
      :margin-right "1.5em"))
    (("#title span")
     (:color "#fa7000"))
    (("#menu")
     (:margin 0
      :padding 0
      :display "inline-block"))
    (("#menu li")
     (:display "inline-block"
      :list-style "none"
      :font-weight "bold"
      :text-align "center"
      :padding "0.5em 1em"))
    (("#menu li a")
     (:color "#444"))
    (("#menu li a:hover")
     (:color "#38a5ff"))
    (("#menu li.selected")
     (:background-color "#ddd"
      :border-radius "0.5em"))
    (("#menu li.selected a")
     (:color "#38a5ff"))
    (("#wrapper")
     (:background-color "#eee"
      :width "80%"
      :height "100%"
      :display "table"
      :margin "0 auto"))
    (("#main")
     (:padding "4em 1em 3em 1em"
      :overflow "hidden"))
    (("#main p")
     (:font-size "12pt"
      :padding-bottom "0em"))
    (("#main h1")
     (:color "#444"
      :font-size "14pt"
      :margin 0
      :padding-bottom "0.5em"
      :word-spacing "0.1em"))
    (("#main h2")
     (:color "#38a5ff"
      :font-size "14pt"
      :font-weight "bold"))
    (("#main h3")
     (:color "#fa7000"
      :font-size "12pt"
      :font-weight "bold"))
    (("#main li")
     (:margin-bottom "0.5em"))
    (("#footer")
     (:padding "1em 0 1em 0"
      :font-size "8pt"
      :width "80%"
      :position "fixed"
      :margin "0 auto"
      :bottom 0
      :left 0
      :right 0
      :font-size "8pt"
      :line-height "1em"
      :text-align "center"
      :background-color "#eee"
      :border-top "1px solid #ddd"))))

