;;; Personal -- my personal emacs settings that aren't part of Prelude
;;; Commentary:
;;; not much else to say

;;; Code:
(setq prelude-whitespace t)
(setq-default tab-width 4)
(electric-indent-mode +1)
(load-theme 'wombat t)

(add-hook 'prelude-mode-hook 'lucid-mode)
(add-hook 'ensime-mode-hook 'ensime-aux-mode)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'projectile-mode-hook 'projectile-aux-mode)

;; make mode line cleaner for scala
(add-hook 'projectile-mode-hook        '(lambda() (diminish 'projectile-mode)))
(add-hook 'ensime-mode-hook            '(lambda() (diminish 'ensime-mode " e")))
(add-hook 'company-mode-hook           '(lambda() (diminish 'company-mode)))
(add-hook 'prelude-mode-hook           '(lambda() (diminish 'prelude-mode)))
(add-hook 'helm-mode-hook              '(lambda() (diminish 'helm-mode)))
(add-hook 'magit-auto-revert-mode-hook '(lambda() (diminish 'magit-auto-revert-mode)))
(add-hook 'subword-mode-hook           '(lambda() (diminish 'subword-mode)))
(add-hook 'yas-minor-mode-hook         '(lambda() (diminish 'yas-minor-mode)))
(add-hook 'whitespace-mode-hook        '(lambda() (diminish 'whitespace-mode)))
(add-hook 'smartparens-mode-hook       '(lambda() (diminish 'smartparens-mode)))
(add-hook 'lucid-mode-hook             '(lambda() (diminish 'lucid-mode)))

(setq mode-require-final-newline nil)
(setq require-final-newline nil)

;; kill C-z
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-x C-z") nil)

(global-flycheck-mode -1)
(remove-hook 'prog-mode-hook 'flycheck-mode)
(setq global-flycheck-mode nil)

(lucid-mode 1)

;; env vars
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; go-flymake stuff
;; wordpress :(
(add-hook 'php-mode-hook '(lambda ()
                            (if (wp/exists)
                                (wordpress-mode))))

(setq php-mode-force-pear t)
(add-hook 'php-mode-hook
          '(lambda ()
             (setq indent-tabs-mode t)
             (setq tab-width 4)
             (setq c-basic-indent 4)))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-RET") 'mc/mark-all-like-this)

;;; comment/uncomment
(global-set-key (kbd "C-c C-c C-c") 'comment-or-uncomment-region)

;;; js hooks
(defun my-js2-hook ()
  (require 'js)
  (setq js-indent-level 4
        indent-tabs-mode t
        c-basic-offset 4))
(add-hook 'js2-mode-hook 'my-js2-hook)

                                        ;(setq less-css-indent-level 4)
(setq cssm-indent-function #'css-c-style-indenter)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq prelude-flyspell nil)
(setq prelude-guru nil)

(scroll-bar-mode -1)

(defun two-tab-width ()
  (setq tab-width 2))
(add-hook 'scala-mode-hook 'two-tab-width)

(setq ruby-indent-level 2)
(add-hook 'ruby-mode-hook 'two-tab-width)
(defun ruby-no-tabs ()
  (setq indent-tabs-mode nil))
(add-hook 'ruby-mode-hook 'ruby-no-tabs)

(add-hook 'term-mode-hook 'lucid-mode)

;; make some shells
(setq sbt-cmd "rlwrap -a sbt -mem 500")
(setq lucid-list
      (list
       (list "cache-service" (vector "/var/lucid/cache-service/server" " " 9001 t sbt-cmd))
       (list "admin-console" (vector "/var/lucid/admin-console/server" " " 9002 t sbt-cmd))
       (list "chart-db" (vector "/var/lucid/chart/database-manager" " " 9003 t sbt-cmd))
       (list "font-service" (vector "/var/lucid/font-service/server" " " 9004 t sbt-cmd))
       (list "mailing-service" (vector "/var/lucid/mailing-service/server" " " 9005 t sbt-cmd))
       (list "pdf-service" (vector "/var/lucid/pdf-service/server" " " 9006 t sbt-cmd))
       (list "piezo" (vector "/var/lucid/piezo/admin" "-Dorg.quartz.properties=/var/lucid/piezo/admin/conf/quartz.properties" 11001 t sbt-cmd))
       (list "analytics-service" (vector "/var/lucid/analytics-service/server" " " 9008 t sbt-cmd))
       (list "reporting-service" (vector "/var/lucid/reporting-service/server" " " 9009 t sbt-cmd))
       (list "admin2" (vector "/var/lucid/admin/server" " " 9010 t sbt-cmd))
       (list "visio-service" (vector "/var/lucid/visio-service/server" " " 9011 t sbt-cmd))
       (list "image-service" (vector "/var/lucid/image-service/server" " " 9012 t sbt-cmd))
       (list "user-service" (vector "/var/lucid/user-service/server" " " 9013 t sbt-cmd))
       (list "chart-web" (vector "/var/lucid/chart/chart-web" " " 9014 t sbt-cmd))
       (list "document-service" (vector "/var/lucid/document-service/server" " " 9015 t sbt-cmd))
       (list "event-server" (vector "/var/lucid/eventserver" " " 31419 t sbt-cmd))
       (list "selenium" (vector "/var/lucid/chart/cake/app/lucidchart-tools/selenium" " " 0 t "./selenium"))))

(defun lucid-get (name)
  (elt (assoc-string name lucid-list) 1))

(defun strrd (name)
  (format "*%s*" name))

(defun lucid-start-service-cmds (name dir opts port run cmd)
  (sleep-for 1)
  (process-send-string name (format "cd %s\n" dir))
  (process-send-string name "export JVM_MEMORY_INITIAL=\"128m\"\n")
  (process-send-string name "export JVM_MEMORY_MAX=\"512m\"\n")
  (process-send-string name "export JVM_STACK_SIXE=\"5m\"\n")
  (process-send-string name "export JVM_MAX_PERM_SIZE=\"512m\"\n")
  (process-send-string name (format "%s\n" cmd))
  (if (string= cmd sbt-cmd)
      ((lambda ()
         (process-send-string name (format "run %s %d" opts port))
         (if run (process-send-string name "\n") (process-send-string name "\n\C-d\C-d"))))
    ))

(defun lucid-start (name)
  (interactive (list (completing-read "Target: " (mapcar 'car lucid-list))))
  (setq service (lucid-get name))
  (if (get-buffer (strrd name))
      (lucid-terminate name))
  (ansi-term (getenv "SHELL") name)
  (sleep-for 1)
  (lucid-start-service-cmds
   (strrd name)
   (elt service 0) (elt service 1) (elt service 2) (elt service 3) (elt service 4)))

(defun lucid-stop (name)
  (interactive "sTarget: ")
  (process-send-string (strrd name) "\C-d"))

(defun lucid-terminate (name)
  (interactive "sTarget: ")
  (lucid-stop name)
  (process-send-string (strrd name) "\C-d\C-d")
  (kill-buffer (strrd name)))

;; ansi-term
(setq term-buffer-maximum-size 0)

;; focus follows mouse
(setq mouse-autoselect-window t)

(setq ruby-indent-tabs-mode t)
(defvaralias 'ruby-indent-level 'tab-width)

;; Status Code Helpers

(fset 'jump-to-routes-file
      "\C-s.main\C-m\M-b\C-b\M-\S-b\M-w\C-cpf\C-y.scala\C-m")

(global-set-key (kbd "C-z g") 'jump-to-routes-file)

(persp-mode)
(require 'persp-projectile)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

;; open project macros
(defun open-or-jump-to-persp (project path old-name)
  (interactive)
  (if (member project (persp-names))
      (persp-switch project)
    ((lambda ()
       (projectile-persp-switch-project path)))))

(defun do-nothing())

(global-set-key (kbd "C-z C-a")     '(lambda () (interactive) (open-or-jump-to-persp "admin2" "~/Private/code/admin/server/" "server")))
(global-set-key (kbd "C-z c C-n")   '(lambda () (interactive) (open-or-jump-to-persp "analytics-client" "~/Private/code/analytics-service/client/" "client")))
(global-set-key (kbd "C-z C-n")     '(lambda () (interactive) (open-or-jump-to-persp "analytics-service" "~/Private/code/analytics-service/server/" "server")))
(global-set-key (kbd "C-z C-k")     '(lambda () (interactive) (open-or-jump-to-persp "cake" "~/Private/code/chart/cake/" "cake")))
(global-set-key (kbd "C-z C-w")     '(lambda () (interactive) (open-or-jump-to-persp "webroot" "~/Private/code/chart/cake/app/webroot/" "webroot")))
(global-set-key (kbd "C-z C-h")     '(lambda () (interactive) (open-or-jump-to-persp "chart-web" "~/Private/code/chart/chart-web/" "chart-web")))
(global-set-key (kbd "C-z C-f")     '(lambda () (interactive) (open-or-jump-to-persp "chef" "~/Private/code/chef/" "chef")))
(global-set-key (kbd "C-z C-d")     '(lambda () (interactive) (open-or-jump-to-persp "core-db" "~/Private/code/core/db/" "db")))
(global-set-key (kbd "C-z C-m")     '(lambda () (interactive) (open-or-jump-to-persp "core-modules" "~/Private/code/core/modules/" "modules")))
(global-set-key (kbd "C-z C-t")     '(lambda () (interactive) (open-or-jump-to-persp "core-util" "~/Private/code/core/util/" "util")))
(global-set-key (kbd "C-z C-")      '(lambda () (interactive) (open-or-jump-to-persp "document-service" "~/Private/code/document-service/server/" "server")))
(global-set-key (kbd "C-z c C-i")   '(lambda () (interactive) (open-or-jump-to-persp "image-client" "~/Private/code/image-service/client/" "client")))
(global-set-key (kbd "C-z C-i")     '(lambda () (interactive) (open-or-jump-to-persp "image-service" "~/Private/code/image-service/server/" "server")))
(global-set-key (kbd "C-z C-o")     '(lambda () (interactive) (open-or-jump-to-persp "ops" "~/Private/code/ops/" "ops")))
(global-set-key (kbd "C-z C-p")     '(lambda () (interactive) (open-or-jump-to-persp "pdf-service" "~/Private/code/pdf-service/server/" "server")))
(global-set-key (kbd "C-z C-r")     '(lambda () (interactive) (open-or-jump-to-persp "reporting-service" "~/Private/code/reporting-service/server/" "server")))
(global-set-key (kbd "C-z c C-r")   '(lambda () (interactive) (open-or-jump-to-persp "reporting-client" "~/Private/code/reporting-service/client/" "client")))
(global-set-key (kbd "C-z c c C-r") '(lambda () (interactive) (open-or-jump-to-persp "reporting-common" "~/Private/code/reporting-service/common/" "common")))
(global-set-key (kbd "C-z c C-u")   '(lambda () (interactive) (open-or-jump-to-persp "user-client" "~/Private/code/user-service/client/" "client")))
(global-set-key (kbd "C-z C-u")     '(lambda () (interactive) (open-or-jump-to-persp "user-service" "~/Private/code/user-service/server/" "server")))
(global-set-key (kbd "C-z C-v")     '(lambda () (interactive) (open-or-jump-to-persp "visio-service" "~/Private/code/visio-service/server/" "server")))

(global-set-key (kbd "C-z h") 'hide-region-hide)
(global-set-key (kbd "C-z s") 'hide-region-unhide)

(defun run-git-cola ()
  "Run `git gui' for the current git repository."
  (interactive)
  (let* ((default-directory (magit-get-top-dir)))
    (call-process "git-cola" nil 0 nil)))

(global-set-key (kbd "C-c C-a g") nil)
(global-set-key (kbd "C-c C-a g") 'run-git-cola)

(provide 'personal)
;;; personal.el ends here
