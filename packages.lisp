(defpackage #:procrypt
  (:use :cl
        :postmodern
        :hunchentoot
        :sexml
        :cl-fad
        :babel)
  (:import-from :css-lite
                :css)
  (:import-from :ironclad
                :pbkdf2-hash-password
                :byte-array-to-hex-string
                :hex-string-to-byte-array))

(sexml:with-compiletime-active-layers
  (sexml:standard-sexml sexml:xml-doctype)
  (sexml:support-dtd
    (merge-pathnames "html5.dtd" (asdf:system-source-directory "sexml"))
    :<))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun components-to-regex (components)
    (format nil "^/+~{~a/~^+~}*$"
            (mapcar (lambda (x)
                      (if (keywordp x)
                        (string-downcase (symbol-name x))
                        "([^/]+)"))
                    components))))
