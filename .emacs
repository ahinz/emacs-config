(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/modes/haskell-mode")
(add-to-list 'load-path "~/.emacs.d/modes/jabber/")
(add-to-list 'load-path "~/.emacs.d/modes/jabber/compat")
(add-to-list 'load-path "~/.emacs.d/modes/multi-web-mode")
(add-to-list 'load-path "~/.emacs.d/modes/js2/")
(add-to-list 'load-path "~/.emacs.d/modes/js2-refactor/")
(add-to-list 'load-path "~/.emacs.d/modes/mark-multiple/")
(add-to-list 'load-path "~/.emacs.d/modes/scala")
(add-to-list 'load-path "~/.emacs.d/modes/ensime")
(add-to-list 'load-path "~/.emacs.d/modes/expand-region")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(global-set-key (kbd "C-c C-o") 'other-frame)
                                            

(global-set-key (kbd "C-c C-e") 'eval-buffer)
(global-set-key (kbd "C-c M-e") (lambda () 
                                  (interactive) 
                                  (eval-region (mark) (point)) 
                                  (exchange-point-and-mark)
                                  (deactivate-mark)))

(load "~/.emacs.d/modes/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Flyspell for git commits and set vline mode
(add-hook 'log-edit-mode-hook
          (lambda ()
            (flyspell-mode t)))

(require 'objc-mode-expansions)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'tango-2-theme)
(require 'paredit)

;; Use aspell instead of ispell (how well do uspell?)
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra")) ;; Note: could use fast or normal but results in degraded performance
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;; Editing objc in a reasonable way...
(setq objc-mode-hook (function (lambda ()
                                 (auto-complete-mode t)
                                 (setq indent-tabs-mode nil)
                                 (setq c-indent-level 4)
                                 (setq c-basic-offset 4))))

;; I'm a wizard!
(add-to-list 'magic-mode-alist
                `(,(lambda ()
                     (and (string= (file-name-extension buffer-file-name) "h")
                          (re-search-forward "@\\<interface\\>" 
					     magic-mode-regexp-match-limit t)))
                  . objc-mode))

;(push ".m" (cadr (assoc "\\.h\\" cc-other-file-alist)))
;(push '("\\.m\\'" (".h")) cc-other-file-alist)
(setq cc-other-file-alist `(("\\.m$" (".h"))
                            ("\\.h$" (".m"))))

(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-C o") 'ff-find-other-file)))

(global-set-key (kbd "C-c e") 'yas/expand)

;; Autojoin
;; (setq erc-auto-query 'bury)
(setq erc-auto-query 'buffer)

(setq erc-autojoin-channels-alist
       '(("azavea.com" "#azavea")
         ("freenode.net" "#okfn" "#scala" "#opentreemap" "#opendatacatalog" "#pycsw" "#geopython" "#geotrellis")))

(global-set-key (kbd "<up>") nil)
(global-set-key (kbd "<right>") nil)
(global-set-key (kbd "<left>") nil)
(global-set-key (kbd "<down>") nil)

(defun window--major-non-side-window (a) nil)

(defun default-erc ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "adammh")
  (erc :server "192.168.1.7" :port 6667 :nick "adam"))

;; Use a better buffer switcher
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-c C-l e") 'erc-buffers)
(global-set-key (kbd "C-c C-l t") 'term-buffers)

(defun erc-buffers ()
  (interactive)
  (list-buffers-with-mode 'erc-mode))

(defun term-buffers ()
  (interactive)
  (list-buffers-with-mode 'term-mode))

(defun list-buffers-with-mode (mode)
  (interactive "SBuffer Mode: ")
  (progn
    (ibuffer-bs-show)
    (ibuffer-filter-disable)
    (ibuffer-filter-by-used-mode mode)))

;; Why would anyone really want there to me a menu bar?
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Scala Stuff
(require 'scala-mode-auto)
(require 'ensime)
(require 'revbufs)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'clojure-mode)

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

(require 'jabber-autoloads)

(setq jabber-account-list
    '(
      ("ahinz@azavea.com"
       (:network-server . "talk.google.com")
       (:port . 5223)
       (:connection-type . ssl))))

;; Never write "\t" characters
(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("" . "/var/tmp/backup"))))
 '(custom-safe-themes (quote ("21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flyspell-incorrect ((t (:foreground "red" :underline t :weight bold))))
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
(defun mk-term (new-buffer-name cmd &rest switches)
  (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun open-remote-ssh (host)
  (interactive "sRemote host: ")
  (mk-term host "ssh" host))

(defun open-term (name)
  (interactive "sName: ")
  (mk-term name "bash"))

(open-term "tty0")
(open-term "tty1")
(open-term "tty2")
(open-term "tty3")
(open-term "tty4")

(global-set-key (kbd "C-c n") 'open-term)

;;;;;;;;;;
;; Sane buffer names
(require 'uniquify) 
(setq 
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

;;;;;;;;;
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)

(add-hook 'sgml-mode-hook
          (lambda ()
            (require 'rename-sgml-tag)
            (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))

;;;;;;;;;;
;; 80 character vertical line
(require 'vline)

(setq vline-column 80)

;;;;;;;;;;
;; Javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'js2-refactor)
(require 'setup-slime-js)

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

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
