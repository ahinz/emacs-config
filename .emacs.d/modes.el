(ah/prepend-plugin-to-load-path "ace-jump-mode")

(require 'ace-jump-mode)

(define-key global-map (kbd "C-c C-v") 'ace-jump-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c C-v") 'ace-jump-mode)))

(ace-jump-mode-enable-mark-sync)
(ah/prepend-plugin-to-load-path "auto-complete")
(ah/prepend-plugin-to-load-path "popup")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(ah/prepend-plugin-to-load-path "change-inner")

(require 'change-inner)
(define-key 'local-map (kbd "C-e") 'change-inner)
(define-key 'local-map (kbd "e") 'change-outer)
(ah/prepend-plugin-to-load-path "nrepl")
(ah/prepend-plugin-to-load-path "clojure-mode")
(require 'clojure-test-mode)
(ah/prepend-plugin-to-load-path "clojure-mode")

(require 'clojure-mode)
(require 'clojure-test-mode)

(setq nrepl-popup-stacktraces nil)

(add-hook 'clojure-mode-hook 'smartparens-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(ah/prepend-plugin-to-load-path "emms/lisp")
(require 'emms-setup)

(emms-devel)
(emms-default-players)

(setq emms-source-file-directory "~/music/artists")
(setq emms-source-file-default-directory "~/music/artists")

(emms-browser-make-filter
 "all"
 (lambda (track)
   (or
    (funcall (emms-browser-filter-only-type 'file) track)
    ;; ignore the pending directory
    (not (funcall
          (emms-browser-filter-only-dir "~/music/artists") track)))))

(require 'emms-info-mp3info)
(add-to-list 'emms-info-functions 'emms-info-mp3info)

(setq later-do-interval 0.001
      emms-info-asynchronously nil)

(setq emms-mode-line-format "")
;; Autojoin
;; (setq erc-auto-query 'bury)
(setq erc-auto-query 'buffer)

(setq erc-autojoin-channels-alist
       '(("azavea.com" "#azavea")
         ("freenode.net" "#okfn" "#scala" "#opentreemap" "#opendatacatalog" "#pycsw" "#geopython" "#geotrellis")))

(defun ah/default-erc ()
  (interactive)
  (let ((realpw (read-passwd "Bouncer Password: ")))
   (erc :server "www.adamhinz.com" :port 5123 :nick "adam" :password (concat "adammh:" realpw))
   (erc :server "www.adamhinz.com" :port 5123 :nick "adammh" :password (concat "adam:" realpw))))

(defun ah/erc-azavea ()
  (interactive)
  (erc :server "192.168.1.7" :port 6667 :nick "adam"))


(ah/prepend-plugin-to-load-path "expand-region")

(require 'expand-region)

(define-key 'local-map (kbd "C-t") 'er/expand-region)
(define-key 'local-map (kbd "C-r") 'er/contract-region)
;; Use aspell instead of ispell (how well do uspell?)
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra")) ;; Note: could use fast or normal but results in degraded performance
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;(flyspell-incorrect ((t (:foreground "red" :underline t :weight bold))))
(ah/prepend-plugin-to-load-path "full-ack")

;; (autoload 'ack-same "full-ack" nil t)
;; (autoload 'ack "full-ack" nil t)
;; (autoload 'ack-find-same-file "full-ack" nil t)
;; (autoload 'ack-find-file "full-ack" nil t)

(require 'full-ack)

(setq ack-executable "/usr/bin/ack-grep")
(ah/prepend-plugin-to-load-path "haskell-mode")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
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
;; -*- coding: utf-8 -*-

(when (require 'ido "ido" t)
  (ido-mode t)
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-virtual-buffers t))

;; Don't randomly switch my ido buffer lists
(setq ido-auto-merge-delay-time 99999)
(require 'iy-go-to-char)
(global-set-key (kbd "M-t") 'iy-go-to-char)
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
;; -*- coding: utf-8 -*-
(ah/prepend-plugin-to-load-path "javap-mode")

(require 'javap-mode)
(add-to-list 'auto-mode-alist '("\\.class$" . javap-mode))
(ah/prepend-plugin-to-load-path "js2")
(require 'js2-mode)
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
(require 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun ah/markdown-mode-hook ()
  (setq fill-column 72)
  (auto-fill-mode t)
  (flyspell-mode t))

(add-hook 'markdown-mode-hook 'ah/markdown-mode-hook)
(ah/prepend-plugin-to-load-path "multi-web-mode")
(require 'multi-web-mode)

(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script type=\"text/javascript\"[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;; (add-hook 'sgml-mode-hook
;;           (lambda ()
;;             (require 'rename-sgml-tag)
;;             (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))
(ah/prepend-plugin-to-load-path "multiple-cursors")

(require 'multiple-cursors)
(define-key 'local-map (kbd "RET") 'mc/edit-lines)
(define-key 'local-map (kbd "C-p") 'mc/mark-previous-like-this)
(define-key 'local-map (kbd "C-n") 'mc/mark-next-like-this)
(define-key 'local-map (kbd "C-m") 'mc/mark-all-like-this)
(define-key 'local-map (kbd "C-SPC") 'set-rectangular-region-anchor)
(ah/prepend-plugin-to-load-path "nrepl")
(require 'nrepl)

(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'smartparens-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(require 'objc-mode-expansions)

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
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;(require 'paredit)
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
(ah/prepend-plugin-to-load-path "rainbow-delimiters")
(require 'rainbow-delimiters)
(ah/prepend-plugin-to-load-path "scala-mode")
(require 'scala-mode2)
;;(require 'ensime)
(require 'smartparens)
(require 'smartparens-config)
(sp-use-paredit-bindings)
(ah/prepend-plugin-to-load-path "smex")
(require 'smex)

(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(require 'tempbuf)
(add-hook 'help-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'grep-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
(require 'term)

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

(global-set-key (kbd "C-c n") 'open-term)

(defun ah/turn-off-yas-minor-mode ()
  (yas-minor-mode -1))

(term-pager-enable)
(add-hook 'term-mode-hook 'ah/turn-off-yas-minor-mode)

(open-term "tty0")
(open-term "tty1")
(open-term "tty2")
(open-term "tty3")
(open-term "tty4")
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")
(require 'vline)

(setq vline-column 80)
;; -*- coding: utf-8 -*-
(ah/prepend-plugin-to-load-path "yaml-mode")

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(ah/prepend-plugin-to-load-path "yasnippet")

(require 'yasnippet)
(yas/global-mode 1)

(global-set-key (kbd "C-c e") 'yas/expand)
