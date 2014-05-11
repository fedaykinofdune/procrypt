(in-package :procrypt)

(defclass module-trade ()
  ((mount :reader mount
          :initarg :mount)
   (routes :reader routes
           :initform '(trade ""))))

(defun trade ()
  "The trading section of the web site."
  (generic-page
    (:title "Trade"
     :selected "Trade")
    (<:h1 "Trade")
    (market-graph)
    (buy-block)
    (sell-block)))

(defun market-graph ()
  (<:div :id "market-graph"
    "Market Graph Goes Here"))

(defun buy-block ()
  (<:div :class "half"
    (<:h2 "Buy Coin")
      (<:div :class "trade-block"
        (<:div :class "trade-list"
          (<:table
            (<:tr
              (<:td "Price")
              (<:td "Quantity")
              (<:td "Total"))
            (loop for i from 1 to 100
                  collect (<:tr
                            (<:td "Test")
                            (<:td "Test")
                            (<:td "Test"))))))))

(defun sell-block ()
  (<:div :class "half"
    (<:h2 "Sell Coin")
      (<:div :class "trade-block"
        (<:div :class "trade-list"
          (<:table
            (<:tr
              (<:td "Price")
              (<:td "Quantity")
              (<:td "Total"))
            (loop for i from 1 to 100
                  collect (<:tr
                            (<:td "Test")
                            (<:td "Test")
                            (<:td "Test"))))))))
