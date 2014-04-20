(in-package :procrypt)

(defun get-binary-path ()
  (namestring
    (truename
      (pathname-directory-pathname
        sb-ext:*core-pathname*))))

(defun executable-p ()
  (string-not-equal (get-binary-path) "/usr/lib/sbcl/"))

(defun get-path (sub-path file-name)
  (let* ((path (format nil "~(~a~)/~(~a~)" sub-path file-name))
         (binary-path (merge-pathnames-as-file
                       (pathname (get-binary-path)) path))
         (package-path (asdf:system-relative-pathname :procrypt path)))
    (if (executable-p)
      (ensure-directories-exist binary-path) 
      (ensure-directories-exist package-path))))

(defun hash-password (password)
  (multiple-value-bind (hash salt)
    (pbkdf2-hash-password (string-to-octets password))
    (list :hash (byte-array-to-hex-string hash)
          :salt (byte-array-to-hex-string salt))))
