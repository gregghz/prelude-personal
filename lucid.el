(defun cake-make (target)
  "Run the make TARGET in the cake directory."
  (interactive "MMake Target: ")
  (let ((default-directory "/var/lucid/main/cake/"))
    (async-shell-command (format "make %s" target))))

(defvar lucid-repo-root "/var/lucid/main")
(defvar lucid-services '("admin2"
                         "chart-web"
                         "user-service"
                         "document-service"
                         "pdf-service"
                         "font-service"
                         "image-service"
                         "visio-service"
                         "event-service"
                         "mailing-service"
                         "analytics-service"
                         "reporting-service"))

(defun lucid--log-file (service)
  "Get the application log for SERVICE."
  (format "%s/%s/logs/application.log" lucid-repo-root service))

(defun lucid-persp ()
  "Make a perspective for lucid service and logs."
  (interactive)
  (persp-switch "lucid-service")
  (if (not (get-buffer "*lucid/sbt*"))
      ((lambda ()
         (ansi-term (getenv "SHELL") "lucid/sbt")
         (process-send-string "*lucid/sbt*" "cd /var/lucid/main\nrlwrap -a sbt -mem 8000\nlucid-start\n"))))
  (dolist (service lucid-services)
    (let ((log-file (lucid--log-file service)))
      (ansi-term (getenv "SHELL") service)
      (process-send-string (format "*%s*" service) (format "tail -f %s\n" log-file)))))

(define-minor-mode lucid-mode
  "Things to make working at Lucid Software a bit more comfortable."
  :lighter " lucid"
  :keymap (let ((map (make-keymap)))
            (define-key map (kbd "C-c C-l s") 'lucid-persp)
            (define-key map (kbd "C-c C-l m") 'cake-make)
            map))
