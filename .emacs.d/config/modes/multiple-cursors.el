(ah/prepend-plugin-to-load-path "multiple-cursors")

(require 'multiple-cursors)
(define-key 'local-map (kbd "RET") 'mc/edit-lines)
(define-key 'local-map (kbd "C-p") 'mc/mark-previous-like-this)
(define-key 'local-map (kbd "C-n") 'mc/mark-next-like-this)
(define-key 'local-map (kbd "C-m") 'mc/mark-all-like-this)
(define-key 'local-map (kbd "C-SPC") 'set-rectangular-region-anchor)
