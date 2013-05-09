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
