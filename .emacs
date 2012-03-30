(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/modes/multi-web-mode")
(add-to-list 'load-path "~/.emacs.d/modes/scala")
(add-to-list 'load-path "~/.emacs.d/modes/ensime")
(add-to-list 'load-path "~/.emacs.d/plugins")

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Why would anyone really want there to me a menu bar?
(menu-bar-mode 0)

;; Scala Stuff
(require 'scala-mode-auto)
(require 'ensime)
(require 'revbufs)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'clojure-mode)

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
 '(font-lock-function-name-face ((t (:foreground "yellow" :weight bold)))))

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

(global-set-key (kbd "C-c v") 'fuzzy-find-in-project)

;; Multi mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script [^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;;;;;;;;;;
;; Terminal helpers
(defun remote-term (new-buffer-name cmd &rest switches)
  (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(defun open-remote-ssh (host)
  (interactive "sRemote host: ")
  (remote-term host "ssh" host))
  

;;;;;;;;;;
;; Sane buffer names
(require 'uniquify) 
(setq 
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")


;;;;;;;;;;
;; 80 character vertical line
(require 'vline)

(setq vline-column 80)



;;;;;;;;;
;; Java/IDEish stuff

(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")    ; This may not be appeared if you have already added.
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

(add-to-list 'load-path "~/.emacs.d/plugins/ajc-java/")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
