(ah/prepend-plugin-to-load-path "magit")
(require 'magit)

(add-hook 'magit-log-edit-mode-hook (lambda ()
    (auto-fill-mode t)
    (setq fill-column 72)    ; rfc 1855 for usenet messages
    (flyspell-mode)))

;; Flyspell for git commits and set vline mode
;; Is this still used?!
(add-hook 'log-edit-mode-hook
          (lambda ()
            (flyspell-mode t)))
