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
    (("#content")
     (:position "relative"
      :top "4em"))

    ;; generic classes
    ((".left")
     (:float "left"))
    ((".right")
     (:float "right"))
    ((".hard-right")
     (:position "absolute"
      :right 0))
    ((".no-select")
     (:user-select "none"
      :-moz-user-select "none"
      :-webkit-user-select "none"
      :-khtml-user-select "none"
      :-o-user-select "none"))

    ;; tables
    (("table")
     (:width "100%"
      :border "1px solid #444"
      :border-radius "0.25em"
      :border-spacing 0
      :margin-bottom "1em"))
    (("table tr:first-child td:first-child")
     (:border-top-left-radius "0.25em"))
    (("table tr:first-child td:last-child")
     (:border-top-right-radius "0.25em"))
    (("table tr:last-child td:first-child")
     (:border-bottom-left-radius "0.25em"))
    (("table tr:last-child td:last-child")
     (:border-bottom-right-radius "0.25em"))
    (("table tr:nth-child(odd) td")
     (:background-color "#ddd"))
    (("table tr:nth-child(even) td")
     (:background-color "#eee"))
    (("table tr:first-child td")
     (:background-color "#38a5ff"
      :font-weight "bold"
      :color "#eee"))
    (("table tr:not(:first-child)")
     (:cursor "pointer"))
    (("table tr:not(:first-child):hover")
     (:color "#38a5ff"))
    (("table td")
     (:padding "0.5em 1em"
      :font "10pt Ubuntu")) 

    ;; header
    (("#header")
     (:padding "1em 0"
      :position "fixed"
      :top 0
      :z-index "10"
      :width "100%"
      :height "2em"
      :white-space "nowrap"
      :background-color "#444"))
    (("#header-left")
     (:width "21em"))
    (("#header-right")
     (:display "inline-block"))
    (("#title")
     (:color "#38a5ff"
      :font "italic bold 2em Exo"
      :line-height "1em"
      :text-align "center"))
    (("#title span")
     (:color "#eee"))
    (("#menu")
     (:margin 0
      :padding 0))
    (("#menu li")
     (:display "inline-block"
      :list-style "none"
      :line-height "2em"
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
     (:padding "1em"
      :margin-bottom "2em"
      :min-height "100%"
      :border-right "1px solid #ddd"))
    (("#sidebar h1")
     (:margin "0 0 1em 0"
      :font-size "14pt"
      :font-weight "normal"))

    ;; main
    (("#main")
     (:margin-left "20em"
      :padding-bottom "2em"))
    (("#main h1")
     (:font-size "16pt"
      :margin "0 0 1em 0"))
    (("#main-content")
     (:padding "1em"))
    ((".half")
     (:width "50%"
      :display "inline-block"))

    ;; trade
    (("#market-graph")
     (:height "15em"
      :line-height "15em"
      :text-align "center"
      :border "1px solid #444"
      :margin-bottom "1em"))
    ((".half:last-child .trade-block")
     (:margin-right 0))
    ((".half h2")
     (:font-size "14pt"
      :margin "0 0 1em 0"))
    ((".trade-block")
     (:height "30em"
      :margin-right "1em"))
    ((".trade-list")
     (:overflow-y "scroll"
      :height "100%"))

    ;; footer
    (("#footer")
     (:padding "1em 0"
      :position "fixed"
      :width "100%"
      :height "1em"
      :bottom 0
      :font "8pt monospace"
      :text-align "center"
      :color "#eee"
      :background-color "#444"))))
