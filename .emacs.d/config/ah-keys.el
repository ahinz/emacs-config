;; Really should add https://github.com/fgallina/region-bindings-mode
(define-prefix-command 'local-map)
(global-set-key (kbd "C-t") 'local-map)


(global-set-key (kbd "C-c C-o") 'other-frame)


(global-set-key (kbd "C-c C-e") 'eval-buffer)
(global-set-key (kbd "C-c M-e") (lambda ()
                                  (interactive)
                                  (eval-region (mark) (point))
                                  (exchange-point-and-mark)
                                  (deactivate-mark)))






;; (require 'mark-more-like-this)
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)

(global-set-key (kbd "<up>") nil)
(global-set-key (kbd "<right>") nil)
(global-set-key (kbd "<left>") nil)
(global-set-key (kbd "<down>") nil)

(provide 'ah-keys)
