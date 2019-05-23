(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-dispatch-when-more-than 20000)
 '(c-default-style (quote ((java-mode . "Google") (other . "k&r"))))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-always-kill t)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-error-regexp-alist
   (quote
    (absoft ada aix ant bash borland python-tracebacks-and-caml cmake cmake-info comma cucumber msft edg-1 edg-2 epc ftnchek iar ibm irix java jikes-file maven jikes-line clang-include gcc-include ruby-Test::Unit gnu lcc makepp mips-1 mips-2 msft omake oracle perl php rxp sparc-pascal-file sparc-pascal-line sparc-pascal-example sun sun-ada watcom 4bsd gcov-file gcov-header gcov-nomark gcov-called-line gcov-never-called perl--Pod::Checker perl--Test perl--Test2 perl--Test::Harness weblint guile-file guile-line)))
 '(compilation-scroll-output (quote first-error))
 '(compilation-skip-threshold 2)
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ensime-graphical-tooltips t)
 '(ensime-sbt-command "/usr/local/bin/sbt -jvm-debug 9999")
 '(ensime-search-interface (quote helm))
 '(ensime-startup-notification nil)
 '(feature-align-steps-after-first-word t)
 '(feature-enable-back-denting nil)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "target")))
 '(highlight-symbol-idle-delay 0)
 '(hscroll-step 1)
 '(lsp-ui-doc-position (quote bottom))
 '(lsp-ui-doc-use-webkit t)
 '(magit-clone-set-remote\.pushDefault t)
 '(magit-git-executable "git")
 '(org-catch-invisible-edits (quote show))
 '(package-selected-packages
   (quote
    (tide lsp-scala company-lsp npm-mode lsp-ui all-the-icons neotree sh-mode activity-watch-mode iedit auto-complete merlin utop smex flx-ido google-c-style bloop typescript-mode tuareg key-chord ido-completing-read+ go-projectile evil-visualstar smooth-scrolling helm-system-packages system-packages helm-dash help-dash treemacs-projectile treemacs dashboard flymd highlight-symbol dockerfile-mode dash-at-point lsp-mode restclient solarized-theme web-mode helm-core magit-popup sbt-mode swiper-helm csv-mode with-editor yasnippet groovy-mode paradox markdown-mode hydra gradle-mode feature-mode multiple-cursors use-package yaml-mode geiser scala-mode yari inf-ruby json-mode js2-mode rainbow-mode elisp-slime-nav rainbow-delimiters company helm-ag helm-descbinds helm-projectile helm counsel swiper ivy vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window)))
 '(paradox-github-token t)
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(projectile-cache-file "/Users/gher33/.emacs.d/savefile/projectile.cache")
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "target")))
 '(projectile-mode t nil (projectile))
 '(projectile-switch-project-action (quote helm-projectile-find-file))
 '(projectile-tags-backend (quote ggtags))
 '(sbt-hydra:allowed-files-regexp (quote (".*.scala$" ".*/routes$" ".*.html$" ".*.feature$")))
 '(sbt:program-name "sbt")
 '(sbt:program-options (quote ("-Djline.terminal=none")))
 '(sbt:sbt-prompt-regexp "^\\[?[a-zA-Z-:]*]?\\(>\\| \\$\\)[ ]+")
 '(typescript-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-info ((t (:foreground "#BFEBBF"))))
 '(highlight-symbol-face ((t (:background "dark cyan"))))
 '(region ((t (:inverse-video t)))))
