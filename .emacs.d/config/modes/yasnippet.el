(ah/prepend-plugin-to-load-path "yasnippet")

(require 'yasnippet)
(yas/global-mode 1)

(global-set-key (kbd "C-c e") 'yas/expand)
