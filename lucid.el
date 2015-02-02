(setq lucid-sbt-cmd "rlwrap -a sbt -mem 300")
(setq lucid-list
      (list
       (list "admin-console" (vector "/var/lucid/admin-console/server" " " 9002 t lucid-sbt-cmd))
       (list "chart-db" (vector "/var/lucid/chart/database-manager" " " 9003 t lucid-sbt-cmd))
       (list "font-service" (vector "/var/lucid/font-service/server" " " 9004 t lucid-sbt-cmd))
       (list "mailing-service" (vector "/var/lucid/mailing-service/server" " " 9005 t lucid-sbt-cmd))
       (list "pdf-service" (vector "/var/lucid/pdf-service/server" " " 9006 t lucid-sbt-cmd))
       (list "piezo" (vector "/var/lucid/piezo/admin" "-Dorg.quartz.properties=/var/lucid/piezo/admin/conf/quartz.properties" 11001 t lucid-sbt-cmd))
       (list "analytics-service" (vector "/var/lucid/analytics-service/server" " " 9008 t lucid-sbt-cmd))
       (list "reporting-service" (vector "/var/lucid/reporting-service/server" " " 9009 t lucid-sbt-cmd))
       (list "admin2" (vector "/var/lucid/admin/server" " " 9010 t lucid-sbt-cmd))
       (list "visio-service" (vector "/var/lucid/visio-service/server" " " 9011 t lucid-sbt-cmd))
       (list "image-service" (vector "/var/lucid/image-service/server" " " 9012 t lucid-sbt-cmd))
       (list "user-service" (vector "/var/lucid/user-service/server" " " 9013 t lucid-sbt-cmd))
       (list "chart-web" (vector "/var/lucid/chart/chart-web" " " 9014 t lucid-sbt-cmd))
       (list "document-service" (vector "/var/lucid/document-service/server" " " 9015 t lucid-sbt-cmd))
       (list "event-server" (vector "/var/lucid/eventserver" " " 31419 t lucid-sbt-cmd))
       (list "selenium-server" (vector "/var/lucid/chart/cake/app/lucidchart-tools/selenium" " " 0 t "./selenium"))
       (list "selenium" (vector "/var/lucid/chart/cake/tests/UITest" " " 0 t lucid-sbt-cmd))))

(defun lucid-get (name)
  (elt (assoc-string name lucid-list) 1))

(defun lucid-strrd (name)
  (format "*%s*" name))

(defun lucid-start-service-cmds (name dir opts port run cmd)
  (sleep-for 1)
  (process-send-string name (format "cd %s\n" dir))
  (process-send-string name (format "%s\n" cmd))
  (if (string= cmd lucid-sbt-cmd)
      ((lambda ()
        (process-send-string name (format "run %s %d" opts port))
        (if run (process-send-string name "\n") (process-send-string name "\n\C-d\C-d"))))
    ))

(defun lucid-start (name)
  (interactive (list (completing-read "Target: " (mapcar 'car lucid-list))))
  (setq service (lucid-get name))
  (if (get-buffer (lucid-strrd name))
      (lucid-terminate name))
  (ansi-term (getenv "SHELL") name)
  (sleep-for 1)
  (lucid-start-service-cmds
   (lucid-strrd name)
   (elt service 0) (elt service 1) (elt service 2) (elt service 3) (elt service 4)))

(defun lucid-stop (name)
  (interactive "sTarget: ")
  (process-send-string (lucid-strrd name) "\C-d"))

(defun lucid-terminate (name)
  (interactive (list (completing-read "Target: " (mapcar 'car lucid-list))))
  (lucid-stop name)
  (process-send-string (lucid-strrd name) "\C-d\C-d")
  (kill-buffer (lucid-strrd name)))

(define-minor-mode lucid-mode
  "Things to make working at Lucid Software a bit more comfortable."
  :lighter " lucid"
  :keymap (let ((map (make-keymap)))
            (define-key map (kbd "C-c C-l s") 'lucid-start)
            (define-key map (kbd "C-c C-l x") 'lucid-stop)
            map))