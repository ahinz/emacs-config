(ah/prepend-plugin-to-load-path "jabber")

(require 'jabber-autoloads)

(add-hook 'jabber-chat-mode-hook (lambda ()
                                   (flyspell-mode)))

(setq jabber-account-list
    '(
      ("ahinz@azavea.com"
       (:network-server . "talk.google.com")
       (:port . 5223)
       (:connection-type . ssl))))
