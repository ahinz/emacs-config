(ah/prepend-plugin-to-load-path "ace-jump-mode")

(require 'ace-jump-mode)

(define-key global-map (kbd "C-c C-v") 'ace-jump-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c C-v") 'ace-jump-mode)))

(ace-jump-mode-enable-mark-sync)
