(setq ensime-prefer-noninteractive t)

(defun fix-ensime-file ()
  (interactive)
  (shell-command (format "/Users/gher33/bin/fix-ensime-config")))

(defun init-project ()
  (interactive)
  (async-shell-command (format "~/.local/bin/init-project.sh %s" (projectile-project-root))))

(defun init-and-restart-ensime ()
  (interactive)
  (ensime-shutdown)
  (init-project)
  (ensime))

(defun init-and-start-ensime ()
  (interactive)
  (init-project)
  (ensime))

(defun neotree-project-dir ()
  "Open NeoTree using the projectile root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find projectile project root"))))
