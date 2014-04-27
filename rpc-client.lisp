(in-package :procrypt)

(defun rpc-send (address login message)
  "Authenticates to an HTTP server and sends a JSON-encoded message,
   returning the decoded JSON response as a Lisp association list."
  (handler-case
    (with-timeout (10)
      (setf drakma:*header-stream* nil)
      (pushnew '("application" . "json") drakma:*text-content-types*
               :test 'equal)
      (let ((response (drakma:http-request address
                                           :basic-authorization login
                                           :content message)))
        (when response
          (parse response :object-as :alist))))
    (error ())))

(defun query-coin (coin-code command &optional (parameters nil))
  "Send a command to the daemon of the given coin code, returning its
   response."
  (when (find-coin-by-code coin-code)
    (let* ((coin (find-coin-by-code coin-code))
           (address (format nil "http://~a:~a" (address coin) (port coin)))
           (login `(,(username coin) ,(password coin)))
           (message (encode-json `(("method" . ,command)
                                   ("params" . ,parameters)))))
      (rpc-send address login message))))
