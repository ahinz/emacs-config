(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/modes/scala")
(add-to-list 'load-path "~/.emacs.d/modes/ensime")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs_ext")

;; Why would anyone really want there to me a menu bar?
(menu-bar-mode 0)

;; Scala Stuff
(require 'scala-mode-auto)
(require 'ensime)
(require 'revbufs)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; Never write "\t" characters
(setq-default indent-tabs-mode nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("" . "/var/tmp/backup")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Never write "\t" characters
(setq-default indent-tabs-mode nil)

;; turn off tab indenting in scala (ugh) 
(add-hook 'scala-mode-hook 'scala-turnoff-indent-tabs-mode)

;; Move backup files
(defvar user-temporary-file-directory
  (concat temporary-file-directory "/ahinz_emacs_bkp/"))

(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


;; turn on maximum syntax highlighting
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; TRAMP for remote file editing
(add-to-list 'load-path "~/.emacs.d/plugins/tramp/lisp/")
(require 'tramp)

(add-to-list 'Info-default-directory-list "~/.emacs.d/plugins/tramp/info/")

(add-to-list 'load-path "~/.emacs.d/plugins/")

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

(setq ack-executable "/usr/bin/ack-grep")

(add-to-list 'load-path "~/.emacs.d/plugins/fuzzy-finder")
(require 'fuzzy-find-in-project)


;;;;;;;;;;
;; 80 character vertical line
(require 'vline)

;;(setq vline-use-timer nil)
;;(setq vline-visual nil)

;;(defsubst vline-current-column() 80)
;;(defsubst vline-invisible-p (pos) nil)
;;(defsubst vline-visual-p () nil)

(setq vline-column 80)