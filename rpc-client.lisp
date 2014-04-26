(in-package :procrypt)

(defun http-query (address username password command &optional (parameters nil))
  (handler-case
    (with-timeout (10)
      (setf drakma:*header-stream* nil)
      (push '("application" . "json") drakma:*text-content-types*)
      (parse
        (drakma:http-request (concatenate 'string "http://" address)
                      :basic-authorization `(,username ,password)
                      :content (encode-json `(("method" . ,command) ("params" . ,parameters))))
        :object-as :alist))
    (error ())))
