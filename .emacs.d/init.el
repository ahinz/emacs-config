(require 'cask "~/.cask/cask.el")
(cask-initialize)

;(add-to-list 'load-path "~/.emacs.d")

(define-prefix-command 'local-map)
(global-set-key (kbd "C-t") 'local-map)

(require 'ah-modes)



(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
