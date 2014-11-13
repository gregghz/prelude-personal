(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-ac-enable-argument-placeholders nil)
 '(ensime-graphical-tooltips t)
 '(haskell-mode-hook (quote (turn-on-haskell-doc turn-on-haskell-indentation)))
 '(helm-ag-base-command "ag --nocolor --nogroup -U")
 '(magit-diff-options (quote ("--function-context")))
 '(magit-diff-refine-hunk (quote all))
 '(magit-highlight-indentation (quote ((".*" . tabs))))
 '(magit-item-highlight-face (quote magit-item-highlight))
 '(magit-show-diffstat t)
 '(minimap-dedicated-window nil)
 '(projectile-completion-system (quote helm))
 '(projectile-enable-caching t)
 '(projectile-global-mode t)
 '(projectile-globally-ignored-directories (quote (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "target" ".ensime_lucene")))
 '(projectile-globally-ignored-files (quote ("TAGS" ".ensime")))
 '(projectile-indexing-method (quote native))
 '(projectile-switch-project-action (quote projectile-find-file))
 '(projectile-use-git-grep t)
 '(whitespace-action nil)
 '(whitespace-line-column 80000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-comment ((t (:background "dim gray"))))
 '(highlight ((t (:background "#454545" :foreground "#ffffff" :underline t))))
 '(hl-line ((t (:inherit nil :background "#383838" :underline nil))))
 '(magit-blame-culprit ((t (:inherit magit-blame-header :foreground "dark red"))) t)
 '(magit-diff-add ((t (:inherit diff-added :foreground "forest green"))))
 '(magit-diff-del ((t (:inherit diff-removed :foreground "light coral"))))
 '(magit-diff-file-header ((t (:inherit diff-file-header))))
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header))))
 '(magit-item-highlight ((t (:inherit secondary-selection :background "#494949"))))
 '(magit-item-mark ((t (:inherit highlight))))
 '(magit-key-mode-args-face ((t (:inherit widget-field))))
 '(magit-log-head-label-default ((t (:background "Grey50" :box 1))))
 '(magit-log-head-label-head ((t (:background "Grey20" :foreground "White" :box 1))))
 '(magit-log-reflog-label-remote ((t (:background "Grey50" :box 1))))
 '(menu ((t (:background "#3F3F3F" :foreground "#DCDCCC"))))
 '(minimap-active-region-background ((t (:background "SlateGray4"))))
 '(region ((t (:background "#444444" :foreground "#f6f3e8"))))
 '(whitespace-line ((t (:background "#3F3F3F")))))
