(global-auto-revert-mode t)

(add-to-list 'load-path "~/src/cider")
(load "cider-autoloads" t t)

;; Sadness https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25228#152
(define-key special-event-map [config-changed-event] #'ignore)

;; Force the server to use tcp for work-from-mac
(setq server-use-tcp t)
(setq server-host "0.0.0.0")
(setq server-port 7788)

(set-face-attribute 'default nil :height 170)
(set 'inhibit-startup-screen t)
(setq make-backup-files nil)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(defalias 'yes-or-no-p 'y-or-n-p)
(global-subword-mode 1)

(setq eval-expression-print-level nil)

(put 'suspend-frame 'disabled t) ; disable C-z

(setq-default indent-tabs-mode nil)

(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

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

(define-prefix-command 'local-map)

;; Various superfluous white-space. Just say no.
(add-hook 'before-save-hook 'ah:cleanup-buffer-safe 'local)

;; When popping the mark, continue popping until the cursor actually moves
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

(defun ah:smart-start-of-line ()
  (interactive)
  (if (eq (point) (point-at-bol))
      (back-to-indentation)
    (move-beginning-of-line nil)))

(defun ah:eval-and-spaw-mark ()
  (interactive)
  (eval-region (mark) (point))
  (exchange-point-and-mark)
  (deactivate-mark))

(provide 'ah-config)
