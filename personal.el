(setq
 prelude-guru nil
 prelude-use-smooth-scrolling t
 whitespace-line-column 240
 scroll-error-top-bottom t
 prelude-flyspell nil
 mac-option-modifier 'meta
 projectile-project-search-path '("~/workspace/"))

;; dark theme
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; Also works for Java.
;; @TODO: move this to a use-package thing for google-c-style
;; @TODO: make this actually work
(autoload 'google-set-c-style "google-c-style")
(autoload 'google-make-newline-indent "google-c-style")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

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

(use-package ace-window)

(use-package all-the-icons
  ;; :config
  ;; only needed the first time this is loaded
  ;; (all-the-icons-install-fonts)
  )

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

(use-package company-lsp)

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

(use-package gradle-mode)

(use-package highlight-symbol
  :demand t
  :bind (("C-z h h" . highlight-symbol)
         ("C-z h r" . highlight-symbol-query-replace)
         ("C-z h n" . highlight-symbol-next)
         ("C-z h p" . highlight-symbol-prev))
  :config
  (highlight-symbol-mode 1))

(use-package helm
  :diminish helm-mode)

(use-package helm-dash)

(use-package helm-system-packages)

(use-package lsp-mode
  :init (setq lsp-prefer-flymake nil))

(use-package lsp-ui)

(use-package lsp-scala
  :after scala-mode
  :demand t
  :hook (scala-mode . lsp)
  )

(use-package magit
  ;; C-M-s- = hyper. these bindings are mostly to make some ergodox
  ;; things workbetter
  :bind (("C-M-s-g" . magit-status)
         ))

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

(use-package paradox
  :config
  (paradox-enable))

(use-package restclient
  :config
  (add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode)))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :bind (("C-c C-h" . sbt-hydra))
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  (add-hook 'sbt-mode-hook
            (lambda ()
              (setq prettify-symbols-alist
                    `((,(expand-file-name (directory-file-name default-directory)) . ?⌂)
                      (,(expand-file-name "~") . ?~)))
              (prettify-symbols-mode t))))

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$"
  :bind (("C-c C-h" . sbt-hydra)
         ("s-l c" . lsp-capabilities)
         ("s-l d" . lsp-describe-thing-at-point)
         ("M-." . lsp-describe-thing-at-point)
         ("s-l f" . lsp-format-buffer)
         ("s-l g" . lsp-goto-implementation)
         ("s-l h" . lsp-hover)
         ("s-l r" . lsp-restart-workspace)
         ("s-l x" . lsp-ui-flycheck)
         ("s-l o" . lsp-ui-doc)
         ("s-l s" . xref-find-definition)))

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
