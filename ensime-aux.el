(defun ensime-aux-sbt-do-reload ()
  (interactive)
  (sbt-command "reload"))

(defun ensime-aux-sbt-do-scoverage ()
  (interactive)
  (sbt-command "coverage")
  (sbt-command "test"))

(defun ensime-aux-sbt-reload-clean-update-compile ()
  (interactive)
  (sbt-command "reload")
  (sbt-command "clean")
  (sbt-command "update")
  (sbt-command "compile"))

(define-minor-mode ensime-aux-mode
  "Things to make ensime even better."
  :lighter " eaux"
  :keymap (let ((map (make-keymap)))
            (define-key map (kbd "C-c C-b l") 'ensime-aux-sbt-do-reload)
            (define-key map (kbd "C-c C-b C") 'ensime-aux-sbt-do-scoverage)
            (define-key map (kbd "C-C C-b Z") 'ensime-aux-sbt-reload-clean-update-compile)
            map))
