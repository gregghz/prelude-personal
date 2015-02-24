(define-minor-mode projectile-aux-mode
  "Things to make projectile keybinds how I like them."
  :lighter " pa"
  :keymap (let ((map (make-keymap)))
            (define-key map (kbd "C-c p x") 'persp-switch)
            (define-key map (kbd "C-c p s") 'helm-projectile-ag)
            (define-key map (kbd "C-c p i") 'projectile-invalidate-cache)
            map))
