(in-package :procrypt)

(defun web-server ()
  "Creates a new web server object listening for connections."
  (make-instance 'easy-acceptor
                 :port (port *config*)
                 :document-root (get-path "web" (root *config*))))

(defun start-web-server ()
  "Configures and starts the web server."
  (configure-web-server)
  (defparameter *web-server* (web-server))
  (start *web-server*))

(defun stop-web-server ()
  "Stop the web server."
  (stop *web-server*)
  (unmap-routes))

(defun restart-web-server ()
  "Stop and restart the web server."
  (stop-web-server)
  (start-web-server))

(defun register-modules (modules)
  "Registers all of the web site modules with the web server."
  (loop for (module mount) on modules by #'cddr do
        (let ((module (make-instance module :mount mount)))
          (map-routes (routes module) :mount mount))))

(defun map-routes (routes &optional &key (mount ""))
  "Adds all paths of the web site to the web server."
  (loop for (handler path) on routes by #'cddr do
        (let ((path (format nil "^~a~a/?$" mount path)))
          (push (create-regex-dispatcher path handler) *dispatch-table*)))
  (setf (cdr (last *dispatch-table*)) (cons '404-dispatcher nil))
  (push (create-folder-dispatcher-and-handler
          "/images/"
          (get-path "web" (format nil "~a/images/" (root *config*))))
        *dispatch-table*))

(defun unmap-routes ()
  "Removes all paths of the web site from the web server."
  (setf *dispatch-table* nil))

(defun configure-web-server ()
  "Registers all web site modules and defines paths for all resources on the
   web server."
  (register-modules (modules *config*))
  (map-routes (routes *config*)))

(defun reconfigure-web-server ()
  "Re-registers all web site modules and defines paths for all resources on
   the web server."
  (unmap-routes)
  (configure-web-server))

(defun home ()
  "An alias for the web server used to redirect traffic to the main web site
   module."
  (redirect "/overview"))

(defun 404-dispatcher (request)
  "Defines an error page for redirecting traffic to when a web site path does
   not exist."
  '404-page)
