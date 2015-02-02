(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-ac-enable-argument-placeholders nil)
 '(ensime-graphical-tooltips t)
 '(erc-modules (quote (notifications smiley image completion spelling truncate netsplit fill button match track readonly networks ring autojoin noncommands irccontrols move-to-prompt stamp menu list)))
 '(haskell-mode-hook (quote (turn-on-haskell-doc turn-on-haskell-indentation)))
 '(helm-ag-base-command "ag --nocolor --nogroup -U")
 '(helm-candidate-number-limit 1000)
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
 '(projectile-tags-command "ctags-exuberant -Re -f %s %s")
 '(projectile-use-git-grep t)
 '(safe-local-variable-values (quote ((hamlet/basic-offset . 4) (haskell-process-use-ghci . t) (haskell-indent-spaces . 4))))
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
 '(magit-diff-add ((t (:inherit diff-added :foreground "forest green"))) t)
 '(magit-diff-del ((t (:inherit diff-removed :foreground "light coral"))) t)
 '(magit-diff-file-header ((t (:inherit diff-file-header))) t)
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header))) t)
 '(magit-item-highlight ((t (:inherit secondary-selection :background "#494949"))) t)
 '(magit-item-mark ((t (:inherit highlight))) t)
 '(magit-key-mode-args-face ((t (:inherit widget-field))) t)
 '(magit-log-head-label-default ((t (:background "Grey50" :box 1))) t)
 '(magit-log-head-label-head ((t (:background "Grey20" :foreground "White" :box 1))) t)
 '(magit-log-reflog-label-remote ((t (:background "Grey50" :box 1))) t)
 '(menu ((t (:background "#3F3F3F" :foreground "#DCDCCC"))))
 '(minimap-active-region-background ((t (:background "SlateGray4"))) t)
 '(region ((t (:background "#444444" :foreground "#f6f3e8"))))
 '(sbt:error ((t (:inherit error :foreground "firebrick"))))
 '(sbt:info ((t (:inherit success :foreground "forest green"))))
 '(sbt:warning ((t (:inherit warning :foreground "chocolate"))))
 '(whitespace-line ((t (:background "#3F3F3F")))))
