(ah/prepend-plugin-to-load-path "change-inner")

(require 'change-inner)
(define-key 'local-map (kbd "C-e") 'change-inner)
(define-key 'local-map (kbd "e") 'change-outer)
