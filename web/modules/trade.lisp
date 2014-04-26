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
    (<:div :id "trade-block"
      (<:div :class "header" "Buy Coin")
      (<:div :class "content" "Test")
      )))

(defun sell-block ()
  (<:div :class "half"
    (<:div :id "trade-block"
      (<:div :class "header" "Sell Coin")
      (<:div :class "content" "Test")
      )))
