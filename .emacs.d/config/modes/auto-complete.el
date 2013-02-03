(ah/prepend-plugin-to-load-path "auto-complete")
(ah/prepend-plugin-to-load-path "popup")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
