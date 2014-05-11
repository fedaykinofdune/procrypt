(in-package :procrypt)

(defun query-coin (coin-code command &optional (parameters nil))
  "Send a command to the daemon of the given coin code, returning its
   response."
  (when (find-coin-by-code coin-code)
    (let* ((coin (find-coin-by-code coin-code))
           (address (format nil "http://~a:~a" (address coin) (port coin)))
           (login `(,(username coin) ,(password coin)))
           (message (alist->json `(("method" . ,command)
                                   ("params" . ,parameters)))))
      (json-send address login message))))
