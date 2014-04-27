(in-package :procrypt)

(defun get-binary-path ()
  "Return the full path of the program's executable."
  (namestring
    (truename
      (pathname-directory-pathname
        sb-ext:*core-pathname*))))

(defun executable-p ()
  "Returns true if the program is an executable."
  (string-not-equal (get-binary-path) "/usr/lib/sbcl/"))

(defun get-path (sub-path file-name)
  "Returns the path of a resource file relative to the program's directory."
  (let* ((path (format nil "~(~a~)/~(~a~)" sub-path file-name))
         (binary-path (merge-pathnames-as-file
                       (pathname (get-binary-path)) path))
         (package-path (asdf:system-relative-pathname :procrypt path)))
    (if (executable-p)
      (ensure-directories-exist binary-path) 
      (ensure-directories-exist package-path))))

(defun hash-password (password)
  "Returns a list containing a hash and salt of the given password."
  (multiple-value-bind (hash salt)
    (pbkdf2-hash-password (string-to-octets password))
    (list :hash (byte-array-to-hex-string hash)
          :salt (byte-array-to-hex-string salt))))

(defun encode-json (data)
  "Encode a lisp association list to JSON data."
  (with-output-to-string (*standard-output*)
    (encode-alist data)))

(defun satoshi->string (price)
  "Display an integer amount of satoshis as a BTC value string."
  (let* ((price (format nil "~8,'0d" price))
         (index (- (length price) 8))
         (prefix (subseq price 0 index))
         (suffix (subseq price index)))
    (if (>= index 1)
      (format nil "~a.~a" prefix suffix)
      (format nil "0.~a" price))))

