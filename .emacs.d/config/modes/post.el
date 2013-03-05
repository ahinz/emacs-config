(autoload 'post-mode "post" "mode for e-mail" t)
(add-to-list 'auto-mode-alist
             '("\\.*mutt-*\\|.article\\|\\.followup"
                . post-mode))

(add-hook 'post-mode-hook
  (lambda ()
    (flyspell-mode)
    (auto-fill-mode t)
    (setq fill-column 72)    ; rfc 1855 for usenet messages
    ;;(footmode-mode t)
    ))
