(defun sim-open-bitbucket-url ()
  (interactive)
  (let ((bitbucket-url (sim-bitbucket-url)))
    (start-process (concat "open " bitbucket-url) nil "open" bitbucket-url)))

(defun sim-kill-bitbucket-url ()
  (interactive)
  (kill-new (sim-bitbucket-url)))

(global-set-key (kbd "C-z o") 'sim-open-bitbucket-url)
(global-set-key (kbd "C-z k") 'sim-kill-bitbucket-url)

(defun sim-bitbucket-url ()
  (let* ((sim-prefix "/Users/gher33/workspace/")
         (current-file (replace-regexp-in-string sim-prefix "" (buffer-file-name)))
         (parts (split-string current-file "/"))
         (current-project (car parts))
         (path (string-join (cdr parts) "/"))
         (current-line (sim-line-range))
         (branch ()))
    (concat "https://bitbucket.nike.com/projects/RSTINV/repos/" current-project "/browse/" path "?at=refs%2Fheads%2F" branch "#" current-line)))

(defun sim-line-number ()
  (car (cdr (split-string (what-line) " "))))

(defun sim-line-range ()
  (if (use-region-p)
      (let* ((start (region-beginning))
             (end (region-end))
             (start-line (save-excursion
                           (goto-char start)
                           (sim-line-number)))
             (end-line (save-excursion
                         (goto-char end)
                         (sim-line-number))))
        (format "%s-%s" start-line end-line))
    (sim-line-number)))
