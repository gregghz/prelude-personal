(setq
 prelude-guru nil
 prelude-use-smooth-scrolling t
 whitespace-line-column 240
 scroll-error-top-bottom t
 prelude-flyspell nil
 mac-option-modifier 'meta
 projectile-project-search-path '("~/workspace/")
 ;; Some nice backup settings
 backup-by-copying t
 backup-directory-alist '((".*" . "~/.saves/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 auto-save-file-name-transforms '((".*" "~/.saves/" t)))

;; dark theme
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; Also works for Java.
;; @TODO: move this to a use-package thing for google-c-style
;; @TODO: make this actually work
(autoload 'google-set-c-style "google-c-style")
(autoload 'google-make-newline-indent "google-c-style")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(setq c-default-style '((java-mode . "Google") (other . "k&r")))

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-x o"))
(global-unset-key (kbd "S-w"))
(global-unset-key (kbd "s-l"))
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "S-n") 'make-frame-command)
(global-set-key (kbd "S-w") 'delete-frame)
(global-set-key (kbd "S-q") 'save-buffers-kill-terminal)

(global-set-key [wheel-right] 'scroll-left)
(global-set-key [wheel-left] 'scroll-right)

;; make mode line cleaner for scala
(add-hook 'prelude-mode                '(lambda() (diminish 'prelude-mode)))
(add-hook 'magit-auto-revert-mode-hook '(lambda() (diminish 'magit-auto-revert-mode)))
(add-hook 'subword-mode-hook           '(lambda() (diminish 'subword-mode)))
(add-hook 'yas-minor-mode-hook         '(lambda() (diminish 'yas-minor-mode " y")))
(add-hook 'whitespace-mode-hook        '(lambda() (diminish 'whitespace-mode)))
(add-hook 'smartparens-mode-hook       '(lambda() (diminish 'smartparens-mode)))
(add-hook 'persp-mode-hook             '(lambda() (diminish 'persp-mode)))
(add-hook 'which-key-mode-hook         '(lambda() (diminish 'which-key-mode)))
(add-hook 'visual-line-mode-hook       '(lambda() (diminish 'visual-line-mode)))
(add-hook 'beacon-mode-hook            '(lambda() (diminish 'beacon-mode)))

;; bloop
(add-to-list 'compilation-error-regexp-alist-alist '(bloop "^\\[E\\] \\[E[0-9]+\\] \\(.*\\):\\([0-9]+\\):\\([0-9]+\\)$" 1 2 3))
(add-to-list 'compilation-error-regexp-alist 'bloop)

;; sh-mode
(when (fboundp 'sh-mode)
  (defun sh-mode-config ()
    "For use in `sh-mode-hook'."
    (local-set-key (kbd "C-c C-e") 'xah-run-current-file))

  (add-hook 'sh-mode-hook 'sh-mode-config))

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package ace-window
  :config
  (setq aw-dispatch-when-more-than 20000))

(use-package all-the-icons
  ;; :config
  ;; only needed the first time this is loaded
  ;; (all-the-icons-install-fonts)
  )

(use-package autorevert
  :config
  (global-auto-revert-mode +1)
  (setq auto-revert-interval 2
        auto-revert-check-vc-info t
        global-auto-revert-non-file-buffers t
        auto-revert-verbose nil))

(use-package bloop
  :load-path "personal/"
  :bind (("s-b c" . bloop-compile)
         ("s-b g" . bloop-show-current-project)
         ("s-b o" . bloop-test-only)
         ("s-b t" . bloop-test)
         ("s-b a" . bloop-repeat)))

(use-package buffer-expose
  :load-path "~/workspace/buffer-expose/"
  :bind (("<backtab>" . buffer-expose)))

(use-package company
  :config
  (setq company-quickhelp-color-background "#4F4F4F"
        company-quickhelp-color-foreground "#DCDCDC"))

(use-package company-lsp
  :commands company-lsp)

(use-package dash-at-point
  :bind (("C-c C-d i" . dash-at-point)
         ("C-c C-d e" . dash-at-point-with-docset)))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5))))

;; (use-package ensime
;;   :ensure t
;;   :pin melpa-stable)

(use-package feature-mode
  :config
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
  (setq feature-step-search-path "cucumber/**/StepDefs.*")
  :bind (:map feature-mode-map
              ("M-." . find-step-def)))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package flymd)

(use-package frame
  :ensure nil
  :config
  (setq initial-frame-alist (quote ((fullscreen . maximized))))
  (blink-cursor-mode -1)
  (when (member "Source Code Variable" (font-family-list))
    (set-frame-font "Source Code Variable-13:weight=light" t t))
  ;; (when (member "Space Mono" (font-family-list))
  ;;   (set-frame-font "Space Mono-13:weight=regular" t t))
  )

(use-package gradle-mode)

(use-package helm
  :diminish helm-mode)

(use-package helm-dash)

(use-package helm-lsp
  :commands help-lsp-workspace-symbol)

;; it's too slow
;; (use-package helm-posframe
;;   :config
;;   (setq helm-posframe-parameters '((internal-border-width . 10)
;;                                    (internal-border-color . "#202020")
;;                                    (min-width . 70)
;;                                    (min-height . 20)
;;                                    (respect-header-line . t))
;;         helm-posframe-poshandler  'posframe-poshandler-frame-top-center)
;;   (helm-posframe-enable))

(use-package helm-system-packages)

(use-package hide-lines
  :bind (("s-l h" . hide-lines-matching)
         ("s-l s" . hide-lines-show-all)
         ("s-l r" . hide-lines-not-matching)))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :diminish
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character 9615) ; left-align vertical bar
  (setq highlight-indent-guides-auto-character-face-perc 20))

(use-package highlight-symbol
  :demand t
  :diminish
  :bind (("C-z h h" . highlight-symbol)
         ("C-z h r" . highlight-symbol-query-replace)
         ("C-z h n" . highlight-symbol-next)
         ("C-z h p" . highlight-symbol-prev))
  :hook (prog-mode . highlight-symbol-mode)
  :config
  (setq highligh-symbol-idle-delay 0.3))

(use-package lsp-mode
  :commands lsp
  :bind (("s-l a" . lsp-execute-code-action)
         ("s-l f" . lsp-find-implementation)
         ("s-l g" . lsp-goto-implementation)
         ("s-l r" . lsp-rename))
  :hook
  ((prog-mode . lsp))

  :config
  (setq
   lsp-prefer-flymake nil
   lsp-enable-snippet t
   lsp-keep-workspace-alive nil
   lsp-metals-server-command "/Users/gher33/.local/bin/metals-emacs"))

(use-package lsp-treemacs
  :config
  (lsp-metals-treeview-enable t))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq
   lsp-ui-doc-include-signature t
   lsp-ui-doc-position 'bottom
   lsp-ui-doc-use-webkit t
   lps-ui-flycheck-list-position 'bottom))

(use-package magit
  ;; C-M-s- = hyper. these bindings are mostly to make some ergodox
  ;; things workbetter
  :bind (("C-M-s-g" . magit-status))
  :config
  (setq
   magit-clone-set-remove\.pushDefault t
   magit-git-executable "git"))

(use-package multiple-cursors
  :bind (
         ;; Mark one more occurrence
         ("C-c C-m a" . mc/mark-all-like-this)
         ("C-c C-m n" . mc/mark-next-like-this-symbol)
         ("C-c C-m p" . mc/mark-previous-symbol-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)

         ;; Juggle around with current cursors
         ("C-c C-m u" . mc/unmark-next-like-this)
         ("C-c C-m x" . mc/unmark-previous-like-this)
         ("C-c C-m s" . mc/skip-to-next-like-this)
         ("C-c C-m z" . mc/skip-to-previous-like-this)

         ;; Mark many occurrences
         ("C-c C-m e" . mc/edit-beginnings-of-lines)
         ("C-c C-m a" . mc/mark-all-symbols-like-this)
         ("C-c C-m r" . mc/mark-all-in-region)
         ("C-c C-m d" . mc/mark-all-symbols-like-this-in-defun)
         ("C-c C-m o" . mc/mark-all-dwim)

         ;; Special
         ("C-c C-m h" . mc/mark-sgml-tag-pair)
         ("C-c C-m 1" . mc/insert-numbers)
         ("C-c C-m /" . mc/insert-letters)
         ("C-c C-m S" . mc/sort-regions)
         ("C-c C-m R" . mc/reverse-regions)))

(use-package npm-mode
  :config
  (npm-global-mode))

(use-package org
  :config
  (setq
   org-agenda-files (list "~/Documents/org/nike.org"
                          "~/Documents/org/life.org")))

(use-package paradox
  :config
  (paradox-enable))

(use-package projectile
  :config
  (setq
   projectile-cache-file "~/.emacs.d/savefile/projectile.cache"
   projectile-enable-caching t
   projectile-globally-ignored-directories '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "target")
   projectile-switch-project-action 'helm-projectile-find-file
   projectile-tags-backend 'ggtags
   ))

(use-package restclient
  :config
  (add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode)))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :bind (("C-c C-h" . sbt-hydra))
  :hook
  (before-save . lsp-format-buffer)
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  ;(setq
   ;sbt:sbt-prompt-regexp "^\\[?[a-zA-Z-:]*]?\\(>\\| \\$\\)[ ]+")
  (add-hook 'sbt-mode-hook
            (lambda ()
              (setq prettify-symbols-alist
                    `((,(expand-file-name (directory-file-name default-directory)) . ?⌂)
                      (,(expand-file-name "~") . ?~)))
              (prettify-symbols-mode t))))

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$"
  :bind (("C-c C-h" . sbt-hydra)
         ;; ("s-l c" . lsp-capabilities)
         ;; ("s-l d" . lsp-describe-thing-at-point)
         ;; ("M-." . lsp-describe-thing-at-point)
         ;; ("s-l f" . lsp-format-buffer)
         ;; ("s-l g" . lsp-goto-implementation)
         ;; ("s-l h" . lsp-hover)
         ;; ("s-l r" . lsp-restart-workspace)
         ;; ("s-l x" . lsp-ui-flycheck)
         ;; ("s-l o" . lsp-ui-doc)
         ;; ("s-l s" . xref-find-definition)
         ))

(use-package smartparens
  :bind (:map smartparens-mode-map
              ("M-p c" . sp-copy-sexp)
              ("M-p m" . sp-mark-sexp)
              ("M-p x" . sp-clone-sexp)
              ("M-p a" . sp-absorb-sexp)
              ("M-p r" . sp-rewrap-sexp)))

(use-package smooth-scrolling)

(use-package swiper-helm
  :bind (("C-s" . swiper-helm)))

(use-package system-packages)

(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)))

(use-package typescript-mode)

(use-package yasnippet
  :commands (yas-minor-mode)
  :init
  (progn
    (setq yas-snippet-dirs '("~/.emacs.d/personal/snippets"))
    (add-hook 'java-mode-hook #'yas-minor-mode)
    (add-hook 'scala-mode-hook #'yas-minor-mode))
  :bind
  (([C-tab] . yas-expand))
  :config
  (progn
    (yas-reload-all)))
