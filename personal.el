;;; Personal -- my personal emacs settings that aren't part of Prelude
;;; Commentary:
;;; not much else to say

;;; Code:
(setq prelude-whitespace nil)
(setq-default tab-width 4)
(electric-indent-mode +1)
(load-theme 'wombat t)

;(highlight-symbol-mode t)

(setq mode-require-final-newline nil)
(setq require-final-newline nil)

;(set-face-font 'default "-unknown-Source Code Pro-normal-normal-normal-*-17-*-*-*-m-0-iso10646-1")

;; kill C-z
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-x C-z") nil)

(global-flycheck-mode nil)
;; env vars
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; go-flymake stuff
;(setq exec-path (append exec-path '("/home/gregg/workspace/go/bin")))
;(add-to-list 'load-path "~/workspace/go/src/github.com/dougm/goflymake")
;(require 'go-flymake)

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

(add-to-list 'load-path "/home/gregg/.emacs.d/personal/multiple-cursors.el-master")
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-RET") 'mc/mark-all-like-this)

;;; comment/uncomment
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;;; js hooks
(defun my-js2-hook ()
  (require 'js)
  (setq js-indent-level 4
        indent-tabs-mode t
        c-basic-offset 4))
(add-hook 'js2-mode-hook 'my-js2-hook)

;(setq less-css-indent-level 4)
(setq cssm-indent-function #'css-c-style-indenter)

;; (add-hook 'js2-post-parse-callbacks
;;           (lambda ()
;;             (let ((buf (buffer-string))
;;                   (index 0))
;;               (while (string-match "\\(goog\\.require\\|goog\\.provide\\)('\\(^'.]*\\)" buf index)
;;                 (setq index (+ 1 (match-end 0)))
;;                 (add-to-list 'js2-additional-externs (match-string 2 buf))))))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; handling pairs of things
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)

(setq prelude-flyspell nil)
(setq prelude-guru nil)

;;; fixing some c++11 stuff ...
(require 'font-lock)

(defun --copy-face (new-face face)
  "Define NEW-FACE from existing FACE."
  (copy-face face new-face)
  (eval `(defvar ,new-face nil))
  (set new-face new-face))

(--copy-face 'font-lock-label-face
             'font-lock-keyword-face)
(--copy-face 'font-lock-doc-markup-face
             'font-lock-doc-face)
(--copy-face 'font-lock-doc-string-face
             'font-lock-comment-face)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(add-hook 'c++-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              nil '(
                    ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
                    ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
                    ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
                    ;; PREPROCESSOR_CONSTANT
                    ("\\<[A-Z]+[A-Z_]+\\>" . font-lock-constant-face)
                    ;; hexadecimal numbers
                    ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
                    ;; integer/float/scientific numbers
                    ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
                    ;; user-types (customize!)
                    ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
                    ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
                    ))
             ) t)

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(scroll-bar-mode -1)

;;; ENSIME
;; (add-to-list 'load-path "/home/gregg/.emacs.d/personal/ensime/elisp")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(defun two-tab-width ()
  (setq tab-width 2))
(add-hook 'scala-mode-hook 'two-tab-width)

(defun no-scala-flycheck ()
  (flycheck-mode nil))
(add-hook 'scala-mode-hook 'no-scala-flycheck)

(setq ruby-indent-level 2)
(add-hook 'ruby-mode-hook 'two-tab-width)
(defun ruby-no-tabs ()
  (setq indent-tabs-mode nil))
(add-hook 'ruby-mode-hook 'ruby-no-tabs)

;; make some shells
(setq sbt-cmd "sbt")
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
       (list "event-server" (vector "/var/lucid/eventserver" " " 31419 t sbt-cmd))))

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
  (process-send-string name (format "run %s %d" opts port))
  (if run (process-send-string name "\n") (process-send-string name "\n\C-d\C-d")))

(defun lucid-open (name)
  (interactive)
  (setq service (lucid-get name))
  (if (get-buffer (strrd name))
      (switch-to-buffer (strrd name))
    (ansi-term (getenv "SHELL") name))
  (sleep-for 1)
  (process-send-string (strrd name) (format "cd %s\n" (elt service 0))))

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

(defun lucid-restart (name)
  (interactive "sTarget: ")
  (lucid-terminate name)
  (lucid-start name))

(defun lucid-console (name)
  (interactive "sTarget: ")
  (setq service (lucid-get name))
  (let ((label (format "console: %s" name)))
    (ansi-term (getenv "SHELL") label)
    (sleep-for 1)
    (process-send-string (strrd label) (format "cd %s\n" (elt service 0)))
    (process-send-string (strrd label) "play-2.1.1\n")
    (lucid-console-cmds (strrd label))))

(defun lucid-console-cmds (name)
  (process-send-string name "console\n")
  (process-send-string name "new play.core.StaticApplication(new java.io.File(\".\"))\n"))

(defun lucid-console-restart ()
  (interactive)
  (let ((label (buffer-name)))
    (process-send-string label "\C-d")
    (lucid-console-cmds label)))
(global-set-key "\C-c\C-a\C-l" 'lucid-console-restart)

(defun lucid-service-restart ()
  (interactive)
  (let ((label (buffer-name)))
    (process-send-string label "\C-d\C-d")
    (sleep-for 1)
    (process-send-string label "rlwrap play\n")
    (sleep-for 1)
    (process-send-string label "\C-rrun \n")))

(global-set-key "\C-c\C-a\C-r" 'lucid-service-restart)

(defun lucid-run ()
  (interactive)
  (mapc #'(lambda (data) (lucid-start (car data))) lucid-list))

(defun lucid-terminate-all ()
  (interactive)
  (mapc #'(lambda (data) (lucid-terminate (car data))) lucid-list))

(defun lucid-stop-all ()
  (interactive)
  (mapc #'(lambda (data) (lucid-stop (car data))) lucid-list))

(defun lucid-rebuild (name)
  (interactive)
  (lucid-stop name))

;; ansi-term
(setq term-buffer-maximum-size 0)

;; focus follows mouse
(setq mouse-autoselect-window t)

(setq ruby-indent-tabs-mode t)
(defvaralias 'ruby-indent-level 'tab-width)

(global-git-gutter+-mode t)

;; neat key combos
(global-set-key "\C-c\C-e" "\C-a\C- \C-n\M-w\C-y")

(defun my-copy-to-other-buffer ()
  (interactive)
  (move-end-of-line 1)
  (set-mark-command 1)
  (move-beginning-of-line 1)
  (other-window 1)
  (yank))

(global-set-key (kbd "C-c C-o") 'my-copy-to-other-buffer)

;; Status Code Helpers

(fset 'jump-to-routes-file
      "\C-s.main\C-m\M-b\C-b\M-\S-b\M-w\C-cpf\C-y.scala\C-m")
(fset 'convert-tab
      "\C-s\t\C-m\M-xdelete-backward-char\C-m  ")
(fset 'xresp
      "\C-a\C-sokXml\C-m\C-a\344\344xmlResponse\C-fStatus(status), ")

(global-set-key (kbd "C-z 5") 'status-500)
(global-set-key (kbd "C-z 4") 'status-400)
(global-set-key (kbd "C-z 2") 'status-ok)
(global-set-key (kbd "C-z s") 'add-status)
(global-set-key (kbd "C-z r") 'rwx)
(global-set-key (kbd "C-z g") 'jump-to-routes-file)
(global-set-key (kbd "C-z t") 'convert-tab)
(global-set-key (kbd "C-z i") 'import-resp)

;; close an ansi-term completely
(defun close-term-frame ()
  (interactive)
  (kill-buffer)
  (delete-frame))

(global-set-key (kbd "s-<escape>") 'close-term-frame)

;; service helpers
(defun jump-to-doc-service ()
  (interactive)
  (switch-to-buffer "*document-service*"))
(defun jump-to-chart-web ()
  (interactive)
  (switch-to-buffer "*chart-web*"))
(defun jump-to-user-service ()
  (interactive)
  (switch-to-buffer "*user-service*"))
(defun jump-to-admin2 ()
  (interactive)
  (switch-to-buffer "*admin2*"))
(defun jump-to-reporting-service ()
  (interactive)
  (switch-to-buffer "*reporting-service*"))

(global-set-key (kbd "C-c C-a s") 'lucid-start)
(global-set-key (kbd "C-c C-a d") 'jump-to-doc-service)
(global-set-key (kbd "C-c C-a u") 'jump-to-user-service)
(global-set-key (kbd "C-c C-a c") 'jump-to-chart-web)
(global-set-key (kbd "C-c C-a a") 'jump-to-admin2)
(global-set-key (kbd "C-c C-a r") 'jump-to-reporting-service)
(global-set-key (kbd "C-c C-a x") 'tempo-complete-tag)

;; some magit stuff
(global-set-key (kbd "C-c C-a g") 'magit-run-git-gui)
(global-set-key (kbd "C-c C-a k") 'magit-run-gitk)
(global-set-key (kbd "C-c C-a b") 'magit-blame-mode)
(global-set-key (kbd "C-c C-a p") 'magit-pull)
;; (global-set-key (kbd "C-c C-a s") 'magit-stash)
(global-set-key (kbd "C-c C-a C-s") 'magit-stash-pop)
(global-set-key (kbd "C-c C-a t") 'magit-status)

(which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))

;; switch to test file (or the other way)
;; (defun jump-to-test ()
;;   (interactive)
;;   (setq filename (file-name-nondirectory buffer-file-name))
;;   (setq noext (file-name-sans-extension filename))
;;   (message noext)

;;   (if (projectile
;;  )

(add-to-list 'load-path "/home/gregg/.emacs.d/personal/")
(persp-mode)
(require 'persp-projectile)

(global-set-key (kbd "C-c p a") 'projectile-persp-switch-project)

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

(defun projectile-helm-ag ()
  (interactive)
  (helm-ag (projectile-project-root)))

(defun projectile-helm-do-ag ()
  (interactive)
  (helm-do-ag (projectile-project-root)))

(global-set-key (kbd "C-c g") nil)
(global-set-key (kbd "C-c g") 'projectile-helm-do-ag)
(global-set-key (kbd "C-c C-g") 'projectile-helm-ag)

(global-set-key (kbd "C-z h") 'hide-region-hide)
(global-set-key (kbd "C-z s") 'hide-region-unhide)

(defun magit-just-amend ()
  (interactive)
  (save-window-excursion
    (magit-with-refresh
     (shell-command "git --no-pager commit --amend --reuse-message=HEAD"))))

;; (eval-after-load "magit"
;;   '(define-key magit-status-mode-map (kbd "C-c C-a") 'magit-just-amend))

(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))
(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))
(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

(defun run-git-cola ()
  "Run `git gui' for the current git repository."
  (interactive)
  (let* ((default-directory (magit-get-top-dir)))
    (call-process "git-cola" nil 0 nil)))

(global-set-key (kbd "C-c C-a g") nil)
(global-set-key (kbd "C-c C-a g") 'run-git-cola)

(provide 'personal)
;;; personal.el ends here
