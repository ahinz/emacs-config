;; For homebrew

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if (file-directory-p "/usr/local/share/emacs/site-lisp/cask/")
    (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el"))
(if (file-directory-p (expand-file-name "~/.cask/"))
    (require 'cask (expand-file-name "~/.cask//cask.el")))

(cask-initialize)

;; Grab homebrew executables
(setq exec-path (append exec-path '("/usr/local/bin")))

(add-to-list 'load-path "~/.emacs.d/lisp")

(define-prefix-command 'local-map)
(global-set-key (kbd "C-t") 'local-map)

(require 'ah-modes)



(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(package-selected-packages
   (quote
    (gherkin-mode yaml-mode use-package smex sbt-mode rainbow-delimiters projectile markdown-mode magit js2-mode jabber iy-go-to-char ido-completing-read+ helm haskell-mode color-theme-sanityinc-tomorrow coffee-mode change-inner ag ace-jump-mode)))
 '(tramp-syntax (quote default) nil (tramp)))


