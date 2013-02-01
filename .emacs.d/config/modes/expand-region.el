(ah/prepend-plugin-to-load-path "expand-region")

(require 'expand-region)

(define-key 'local-map (kbd "C-t") 'er/expand-region)
(define-key 'local-map (kbd "C-r") 'er/contract-region)
