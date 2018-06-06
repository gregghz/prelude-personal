(setq
 prelude-guru nil
 prelude-use-smooth-scrolling t
 whitespace-line-column 240
 scroll-error-top-bottom t
 prelude-flyspell nil
 mac-option-modifier 'meta)

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "S-n") 'make-frame-command)
(global-set-key (kbd "S-w") 'delete-frame)
(global-set-key (kbd "S-q") 'save-buffers-kill-terminal)

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

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(use-package ace-window)

(use-package dash-at-point
  :bind (("C-c C-d i" . dash-at-point)
         ("C-c C-d e" . dash-at-point-with-docset)))

(use-package feature-mode
  :config
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
  (setq feature-step-search-path "**/StepDefs.scala"))

(use-package gradle-mode)

(use-package lsp-mode)

(add-to-list 'load-path "/Users/gher33/workspace/lsp-scala")
(require 'lsp-scala)
(setq lsp-scala-server-command '("/Users/gher33/bin/metals" "0.1.0-M1+278-e8e9a327"))

(use-package multiple-cursors
  :bind (
         ;; Mark one more occurrence
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

(use-package paradox
  :config
  (paradox-enable))

(use-package restclient)

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

(use-package swiper-helm
  :bind (("C-s" . swiper-helm)))
