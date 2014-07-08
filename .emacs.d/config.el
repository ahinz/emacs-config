;; I slay thee, you tab!
(setq-default indent-tabs-mode nil)

(put 'suspend-frame 'disabled t) ; disable C-z

;; Not sure why this is needed...
(defun window--major-non-side-window (a) nil)

;; Why would anyone really want there to me a menu bar?
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; turn on maximum syntax highlighting
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)
(global-subword-mode 1)

(setq eval-expression-print-level nil)

(set-face-attribute 'default nil :height 150)

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

;; Use lambda for anonymous functions
(font-lock-add-keywords
 'js2-mode `(("\\(function\\) *("
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) ?λ)
                        nil)))))

;; Use a more-sane modeline
(setq-default mode-line-format
      `(" %e"
        (:eval (propertize "%b " 'face 'font-lock-keyword-face))

        "("
        ,(propertize "%02l" 'face 'font-lock-type-face) ","
        ,(propertize "%02c" 'face 'font-lock-type-face)
        ") "

        "["
        ,(propertize "%p" 'face 'font-lock-constant-face)
        "/"
        ,(propertize "%I" 'face 'font-lock-constant-face)
        "] "

        "*"
        (:eval (propertize "%m" 'face 'font-lock-string-face))
        "* "

        "%M"))

(setq-default header-line-format
      `((:eval erc-modified-channels-object)))


(provide 'ah-basic)


(provide 'ah-config)
(defvar ah:defuns-dir (concat user-emacs-directory "defuns"))

(dolist (defuns (directory-files ah:defuns-dir t "\\w+"))
  (when (not (file-directory-p defuns))
    (load defuns nil nil t)))

(provide 'ah-defuns)
;; Really should add https://github.com/fgallina/region-bindings-mode

(global-set-key (kbd "C-a")
                (lambda ()
                  (interactive)
                  (if (eq (point) (point-at-bol))
                      (back-to-indentation)
                    (move-beginning-of-line nil))))


(define-prefix-command 'local-map)
(global-set-key (kbd "C-t") 'local-map)


(global-set-key (kbd "C-c C-o") 'other-frame)


(global-set-key (kbd "C-c C-e") 'eval-buffer)
(global-set-key (kbd "C-c M-e") (lambda ()
                                  (interactive)
                                  (eval-region (mark) (point))
                                  (exchange-point-and-mark)
                                  (deactivate-mark)))






;; (require 'mark-more-like-this)
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)

(global-set-key (kbd "<up>") nil)
(global-set-key (kbd "<right>") nil)
(global-set-key (kbd "<left>") nil)
(global-set-key (kbd "<down>") nil)

(provide 'ah-keys)
(defvar ah:mode-config-dir (concat user-emacs-directory "config/modes/"))

(defvar ah:modes
  (list "ace-jump"
        "expand-region"
        "emms"
        "vline"
        "change-inner"
        "clojure-preload" ;; nrepl and clojure helpfully
        "nrepl"           ;; depend on each other...?
        "clojure"
        "clojure-test"
        "erc"
        "flyspell"
        "full-ack"
        "haskell"
        "ibuffer"
        "ido"
        "iy-go-to-char"
        "jabber"
        "javap"
        "magit"
        "multiple-cursors"
        "multi-web"
        "objc"
        "package"
        "smartparens"
        "post"
        "rainbow-delimiters"
        "scala"
        "smex"
        "tempbuf"
        "yasnippet"
        "term"
        "yaml"
        "markdown"
        "js"
        "uniquify"))



(dolist (mode-config ah:modes)
  (when (not (file-directory-p mode-config))
    (load (concat ah:mode-config-dir mode-config ".el") nil nil t)))

(provide 'ah-modes)

(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)


(defvar ah/base-packages
  '(ace-jump-mode auto-complete clojure-mode clojure-test-mode clojurescript-mode ac-nrepl
    expand-region full-ack haskell-mode iy-go-to-char jabber js2-mode magit markdown-mode
    nrepl multiple-cursors smartparens rainbow-delimiters smex yasnippet yaml-mode vline magithub
    popup)
  "Package list")

(defun ah/base-packages-p ()
   (loop for p in ah/base-packages
         when (not (package-installed-p p)) do (return nil)
         finally (return t)))

(defun ah/install-packages ()
  (unless (ah/base-packages-p)
    ;; check for new packages (package versions)
    (message "%s" "Refreshing refreshing package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p ah/base-packages)
      (when (not (package-installed-p p))
        (package-install p)))))

(package-initialize)
(ah/install-packages)

(provide 'ah-packages)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/tomorrow-theme")

(load-theme 'tomorrow-night-bright t)

;; Fixes an issue with tomorrow-night-bright theme
(setq ansi-term-color-vector
  [term-face
   term-color-black
   term-color-red
   term-color-green
   term-color-yellow
   term-color-blue
   term-color-magenta
   term-color-cyan
   term-color-white])

(provide 'ah-theme)
(defvar ah:plugin-path "~/.emacs.d/plugins/" "Path to the plugins folder")

(defun ah/prepend-to-load-path (path)
  (add-to-list 'load-path path))

(defun ah/prepend-plugin-to-load-path (path)
  (ah/prepend-to-load-path (concat ah:plugin-path path)))

(ah/prepend-to-load-path ah:plugin-path)

(defun ah/print-bw ()
  (interactive)
  (let ((ps-top-margin 15)
        (ps-left-margin 15)
        (ps-right-margin 15)
        (ps-inter-column 0)
        (ps-print-header nil)
        ;(ps-landscape-mode nil)
        ;(ps-number-of-columns 2)
        (ps-font-size 12.0)
        (ps-line-number-font-size 10)
        (ps-line-number-step 10)
        (ps-print-color-p 'black-white))
    (ps-print-buffer-with-faces)))

(provide 'ah-util)
