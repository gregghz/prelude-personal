;;; Personal -- my personal emacs settings that aren't part of Prelude
;;; Commentary:
;;; not much else to say

(prelude-require-packages '(
                            ag
                            comment-dwim-2
                            erc-image
                            evil-visualstar
                            exec-path-from-shell
                            flycheck-ocaml
                            helm-ag
                            highlight-symbol
                            iedit
                            key-chord
                            merlin
                            mo-git-blame
                            multiple-cursors
                            paradox
                            persp-mode
                            persp-projectile
                            string-inflection
                            tuareg
                            use-package
                            utop
                            ))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; my things
(add-to-list 'load-path "~/.emacs.d/personal/lisp")

(setq use-package-always-ensure t)

(require 'kotlin-mode)

(persp-mode)
(require 'persp-projectile)

(use-package yasnippet
  :init
  (add-to-list 'load-path "~/.emacs.d/personal/yas")
  :config
  (yas-global-mode 1))

;(sp-local-pair 'scala-mode "(" nil :post-handlers '(("||\n[i]" "RET")))
;(sp-local-pair 'scala-mode "{" nil :post-handlers '(("||\n[i]" "RET") ("| " "SPC")))

;;; pretty symbols
(setq global-prettify-symbols-mode 1)
;; (setq scala-prettify-symbols
;;       '(("=>" . ?⇒)
;;         ("<-" . ?←)
;;         ("->" . ?→)
;;         ("<<<" . ?⋘)
;;         (">>>" . ?⋙)
;;         ("lambda" . ?λ)
;;         ("alpha" . ?α)
;;         ("beta" . ?β)
;;         ("Unit" . ?∅)))

;; kill C-z
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-x C-z") nil)

(global-set-key (kbd "C-S-s") nil)

(global-set-key (kbd "C-z s") 'sort-lines)

(use-package highlight-symbol
             :diminish highlight-symbol-mode
             :commands highlight-symbol
             :bind (("C-z h" . highlight-symbol)
                    ("C-z q" . highlight-symbol-remove-all)))

(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

(use-package projectile
  :diminish projectile-mode
  :config
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t))

(use-package company
  :diminish company-mode)

(use-package ensime
  :ensure t
  :pin melpa-stable)

(use-package etags-select
  :commands etags-select-find-tag)

(use-package ggtags)

(global-set-key (kbd "C-c C-h") 'sbt-hydra)
(use-package sbt-mode
  :init
  (defun run-protify ()
    (interactive)
    (sbt-command "protify"))
  (defun run-android-install ()
    (interactive)
    (sbt-command "android:install"))

  :bind
  (("C-c C-a p" . run-protify)
   ("C-c C-a i" . run-android-install)))

;;; Code:
(setq prelude-whitespace t)
(setq-default tab-width 4)
(electric-indent-mode +1)
(load-theme 'wombat t)

(add-hook 'prog-mode-hook '(lambda()
                             (highlight-symbol-mode 1)
                             (rainbow-mode 1)))

;; make mode line cleaner for scala
(add-hook 'prelude-mode                '(lambda() (diminish 'prelude-mode)))
(add-hook 'helm-mode-hook              '(lambda() (diminish 'helm-mode)))
(add-hook 'magit-auto-revert-mode-hook '(lambda() (diminish 'magit-auto-revert-mode)))
(add-hook 'subword-mode-hook           '(lambda() (diminish 'subword-mode)))
(add-hook 'yas-minor-mode-hook         '(lambda() (diminish 'yas-minor-mode " y")))
(add-hook 'whitespace-mode-hook        '(lambda() (diminish 'whitespace-mode)))
(add-hook 'smartparens-mode-hook       '(lambda() (diminish 'smartparens-mode)))
(add-hook 'persp-mode-hook             '(lambda() (diminish 'persp-mode)))
(add-hook 'which-key-mode-hook         '(lambda() (diminish 'which-key-mode)))
(add-hook 'visual-line-mode-hook       '(lambda() (diminish 'visual-line-mode)))
(add-hook 'beacon-mode-hook            '(lambda() (diminish 'beacon-mode)))

(setq mode-require-final-newline nil)
(setq require-final-newline nil)

;; use avy-goto-line instead of goto-line
(global-set-key (kbd "M-g g") nil)
(global-set-key (kbd "M-g M-g") nil)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'avy-goto-line)

;; useful avy bindings
(global-set-key (kbd "C-x C-a c") 'avy-goto-char)
(global-set-key (kbd "C-x C-a l") 'avy-goto-char-in-line)
(global-set-key (kbd "C-x C-a w") 'avy-goto-word-0)
(global-set-key (kbd "C-x C-a j") 'avy-goto-word-1)
(global-set-key (kbd "C-x C-a h") 'avy-goto-line)
(global-set-key (kbd "C-x C-a y") 'avy-copy-line)
(global-set-key (kbd "C-x C-a m") 'avy-move-line)
(global-set-key (kbd "C-x C-a p") 'avy-copy-region)
(global-set-key (kbd "C-x C-a i") 'avy-isearch)

;; ace window
(global-set-key (kbd "C-x w") 'ace-window)

(global-flycheck-mode -1)
(remove-hook 'prog-mode-hook 'flycheck-mode)
(setq global-flycheck-mode nil)

;; env vars
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

(use-package zeal-at-point
  :commands zeal-at-point
  :bind (("C-z C-z" . zeal-at-point))
  :config
  (add-to-list 'zeal-at-point-mode-alist '(kotlin-mode . "android")))

(use-package php-mode
  :commands php-mode
  :config
  (setq php-mode-force-pear t)
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq c-basic-indent 4))

(use-package multiple-cursors
  :bind (;; Mark one more occurrence
         ("C-c m n" . mc/mark-next-like-this-symbol)
         ("C-c m p" . mc/mark-previous-symbol-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)

         ;; Juggle around with current cursors
         ("C-c m u" . mc/unmark-next-like-this)
         ("C-c m x" . mc/unmark-previous-like-this)
         ("C-c m s" . mc/skip-to-next-like-this)
         ("C-c m z" . mc/skip-to-previous-like-this)

         ;; Mark many occurrences
         ("C-c m e" . mc/edit-beginnings-of-lines)
         ("C-c m a" . mc/mark-all-symbols-like-this)
         ("C-c m r" . mc/mark-all-in-region)
         ("C-c m d" . mc/mark-all-symbols-like-this-in-defun)
         ("C-c m o" . mc/mark-all-dwim)

         ;; Special
         ("C-c m h" . mc/mark-sgml-tag-pair)
         ("C-c m 1" . mc/insert-numbers)
         ("C-c m /" . mc/insert-letters)
         ("C-c m S" . mc/sort-regions)
         ("C-c m R" . mc/reverse-regions)))

;;; js hooks
(defun my-js2-hook ()
  (require 'js)
  (setq js-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4))
(add-hook 'js2-mode-hook 'my-js2-hook)

                                        ;(setq less-css-indent-level 4)
(setq cssm-indent-function #'css-c-style-indenter)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq prelude-flyspell nil)
(setq prelude-guru nil)

(scroll-bar-mode -1)

;(defun two-tab-width ()
;  (setq tab-width 2))
;(add-hook 'scala-mode-hook 'two-tab-width)

(setq ruby-indent-level 2)
(add-hook 'ruby-mode-hook 'two-tab-width)
(defun ruby-no-tabs ()
  (setq indent-tabs-mode nil))
(add-hook 'ruby-mode-hook 'ruby-no-tabs)

;; ansi-term
(setq term-buffer-maximum-size 0)

;; focus follows mouse
(setq mouse-autoselect-window t)

(setq ruby-indent-tabs-mode t)
(defvaralias 'ruby-indent-level 'tab-width)

;; Status Code Helpers

;; (fset 'jump-to-routes-file
;;       "\C-s.main\C-m\M-b\C-b\M-\S-b\M-w\C-cpf\C-y.scala\C-m")

;; (global-set-key (kbd "C-z g") 'jump-to-routes-file)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

(global-set-key (kbd "C-z b") 'mo-git-blame-current)

(defun run-git-cola ()
  "Run `git gui' for the current git repository."
  (interactive)
  (let* ((default-directory (magit-get-top-dir)))
    (call-process "git-cola" nil 0 nil)))

(global-set-key (kbd "C-c C-a g") nil)
(global-set-key (kbd "C-c C-a g") 'run-git-cola)
(global-set-key (kbd "C-a") nil)
(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)

(setq magit-last-seen-setup-instructions "1.4.0")

(setq sql-mysql-login-params
      '((user :default "dev")
        (database :default "reporting_service_common")
        (server :default "localhost")))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;; casing

;; Cycle between snake case, camel case, etc.
(require 'string-inflection)
(global-set-key (kbd "C-z i") 'string-inflection-cycle)
(global-set-key (kbd "C-z c") 'string-inflection-camelcase)        ;; Force to CamelCase
(global-set-key (kbd "C-z l") 'string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
(global-set-key (kbd "C-z j") 'string-inflection-java-style-cycle) ;; Cycle through Java styles

(defun my/capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string 0 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(defun my/downcase-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string 0 1))
          (rest-str   (substring string 1)))
      (concat (downcase first-char) rest-str))))

(defun compile-in-parent-directory ()
  (interactive)
  (let ((default-directory
          (if (string= (file-name-extension buffer-file-name) "ml")
              (concat default-directory "..")
            default-directory))))
  (call-interactively #'compile))

(defun android-compile ()
  (interactive)
  (let ((default-directory "/home/gregg/lucid/main/visio-viewer-android"))
    (call-interactively #'compile)))

(add-to-list 'compilation-error-regexp-alist 'kotlin)
(add-to-list 'compilation-error-regexp-alist-alist
             '(kotlin
               "^e: \\([^:]+\\): (\\([0-9]+\\), \\([0-9]+\\)): .*" 1 2 3))

(provide 'personal)
;;; personal.el ends here
