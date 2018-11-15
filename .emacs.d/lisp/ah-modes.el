(require 'use-package)

(use-package ah-tools
  :bind
  (("M-<left>" . ah:shift-left)
   ("M-<right>" . ah:shift-right)))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package ag
  :config
  (setq ag-executable "/usr/local/bin/ag"))

(use-package coffee-mode
  :config
  (setq coffee-tab-width 2))

;; (use-package helm
;;   :demand t
;;   :bind
;;   (("C-x b" . helm-buffers-list))

;;   :init
;;   (progn
;;     (setq helm-buffers-fuzzy-matching 1)

;;     ;; Sort with the following:
;;     ;; - Pattern is prefix
;;     ;; - Timestamp
;;     ;; - Bury the active buffer
;;     (defun ah:candidate-score (pattern abuffer visible-buffers)
;;       (let ((timestamp (with-current-buffer (get-buffer abuffer)
;;                          (float-time buffer-display-time)))
;;             (prefix-match (if (not (null (string-match-p (format "^%s" pattern) abuffer)))
;;                               1000000000
;;                             0))
;;             (bury-visible (if (member abuffer visible-buffers)
;;                               -1000000000
;;                             0)))
;;         (+ timestamp prefix-match bury-visible)))

;;     (defun helm-buffers-sort-transformer (candidates _source)
;;       (if (string= helm-pattern "")
;;           candidates
;;         (let ((active-buffers (mapcar (lambda (w)
;;                                         (with-current-buffer (window-buffer w)
;;                                           (buffer-name)))
;;                                       (window-list-1 nil nil nil))))
;;           (sort candidates
;;                 #'(lambda (s1 s2)
;;                     (> (ah:candidate-score helm-pattern s1 active-buffers)
;;                        (ah:candidate-score helm-pattern s2 active-buffers)))))))))

(use-package prog-mode
  :config
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)))


(use-package ah-config
  :demand t
  :bind
  (("C-t" . local-map)
   ("C-c C-o" . other-frame)
   ("C-c C-e" . eval-buffer)
   ("C-c M-e" . ah:eval-and-swap-mark)
   ("C-a" . ah:smart-start-of-line)))

;; (use-package emacs-lisp-mode
;;   :demand t
;;   :init
;;   (progn
;;     (put 'use-package 'lisp-indent-function 'defun)
;;     (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
;;     (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)))

(use-package use-package
  :config (setq use-package-verbose t)
  :bind ("C-c k" . describe-personal-keybindings))

(use-package font-lock
  :init
  (progn
    ;; turn on maximum syntax highlighting
    (require 'font-lock)
    (setq font-lock-maximum-decoration t)
    (global-font-lock-mode t)))

(use-package color-theme-sanityinc-tomorrow
  :init (load-theme 'sanityinc-tomorrow-bright t)
  :config (set-face-attribute 'mode-line nil
                              :box nil))

(use-package ace-jump-mode
  :defer t
  :bind ("C-c C-v" . ace-jump-mode))


(use-package change-inner
  :defer t
  :bind (("M-i" . change-inner)
         ("M-o" . change-outer)))

;;(use-package paredit-mode)
;;(use-package rainbow-delimiters)

(defun clj-refactor-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package clojure-mode
  :config
  (progn
    (put-clojure-indent 'against-background 'defun)
    (put-clojure-indent 'nextTuple 'defun)
    (put-clojure-indent 'table 'defun)
    (put-clojure-indent 'tr 'defun)
    (put-clojure-indent 'td 'defun)
    (put-clojure-indent 'div 'defun)
    (put-clojure-indent 'header 'defun)
    (put-clojure-indent 'button 'defun)
    (put-clojure-indent 'span 'defun)
    (put-clojure-indent 'nav 'defun)
    (put-clojure-indent 'ul 'defun)
    (put-clojure-indent 'li 'defun)

    (put-clojure-indent 'GET 'defun)
    (put-clojure-indent 'POST 'defun)
    (put-clojure-indent 'fact 'defun)
    (put-clojure-indent 'routes 'defun)

    (put-clojure-indent 'emit-bolt! 'defun)
    (put-clojure-indent 'execute 'defun)
    (put-clojure-indent 'elmt 'defun)

    (add-hook 'clojure-mode-hook #'clj-refactor-hook)
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)))

(use-package clojure-test-mode
  :defer t)

(use-package expand-region
  :defer t
  :bind ("C-t C-t" . er/expand-region))

(use-package flyspell
  :init
  (setq ispell-program-name "aspell"
        flyspell-issue-welcome-flag nil))

;; (use-package c-mode
;;   :demand t
;;   :init
;;   (global-set-key (kbd "C-c o") 'ff-find-other-file)
;;   :bind ("C-c o" . ff-find-other-file))

(use-package haskell-mode
  :defer t
  :config
  (progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)))

(use-package ibuffer
  :config
  (progn
    (global-set-key (kbd "C-x C-b") 'ibuffer)
    (global-set-key (kbd "C-c C-l t") 'ah:term-buffers)

    (defun ah:term-buffers ()
      (interactive)
      (ah:list-buffers-with-mode 'term-mode))

    (defun ah:list-buffers-with-mode (mode)
      (interactive "SBuffer Mode: ")
      (progn
        (ibuffer-bs-show)
        (ibuffer-filter-disable)
        (ibuffer-filter-by-used-mode mode)))))

(use-package ido
  :init (ido-mode t)
  :config
  (progn
    (setq ido-everywhere t
          ido-enable-flex-matching t
          ido-use-virtual-buffers t)

    (setq magit-completing-read-function 'magit-ido-completing-read)

    ;; Don't randomly switch my ido buffer lists
    (setq ido-auto-merge-delay-time 99999)))


(use-package iy-go-to-char
  :defer t
  :bind ("M-t" . iy-go-to-char))

(use-package js2-mode
  :defer t
  :mode (("\\.js$" . js2-mode))
  :init
  (progn
    (font-lock-add-keywords
     'js2-mode `(("\\(function\\) *("
                  (0 (progn (compose-region (match-beginning 1)
                                            (match-end 1) ?λ)
                            nil)))))))

(use-package grep
  :bind ("M-r" . rgrep)
  :config (progn
            (add-to-list 'grep-find-ignored-directories ".cask")
            (add-to-list 'grep-find-ignored-files "*.min.js")
            (add-to-list 'grep-find-ignored-files "*.min.css")))

(use-package magit
  :bind ("<up>" . magit-status)
  :config
  (progn
    (setq magit-auto-revert-mode-lighter "")
    (setq vc-handled-backends nil)

    (defun ah:magit-log-hook ()
      (auto-fill-mode t)
      (setq fill-column 72)
      (flyspell-mode))

    (add-hook 'git-commit-mode-hook 'ah:magit-log-hook)

    ;; This may be obsolete...
    (add-hook 'magit-log-edit-mode-hook 'ah:magit-log-hook)))

(use-package markdown-mode
  :defer t
  :mode ("\\.md$" . markdown-mode)
  :config
  (progn
    (defun ah:markdown-mode-hook ()
      (setq fill-column 72)
      (auto-fill-mode t)
      (flyspell-mode t))

    (add-hook 'markdown-mode-hook 'ah:markdown-mode-hook)))

(use-package uniquify
  :config (setq uniquify-buffer-name-style 'post-forward
                uniquify-separator ":"))

(use-package yaml-mode
  :defer t
  :mode ("\\.yml$" . yaml-mode))

(use-package smex
  :bind ("M-x" . smex)
  :config
  (smex-initialize))

(use-package multiple-cursors
  :bind
  (("C-t RET" . mc/edit-lines)
   ("C-t C-p" . mc/mark-previous-like-this)
   ("C-t C-n" . mc/mark-next-like-this)
   ("C-t C-m" . mc/mark-all-like-this)
   ("C-t C-SPC" . set-rectangular-region-anchor)))

(use-package yasnippet
  :defer t
  :init (yas-global-mode 1)
  :bind ("C-c e" . yas-expand))

(use-package term
  :commands ansi-term
  :demand t
  :bind ("C-c n" . ah:open-term)
  :config
  (progn
    (defun ah:turn-off-yas-minor-mode ()
      (yas-minor-mode -1))

    (add-hook 'term-mode-hook 'ah:turn-off-yas-minor-mode)

    (defun ah:make-term (new-buffer-name cmd &rest switches)
      (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
      (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
      (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
      (set-buffer term-ansi-buffer-name)
      (term-mode)
      (term-char-mode)
      (term-set-escape-char ?\C-x)
      (switch-to-buffer term-ansi-buffer-name))

    (defun ah:open-term (name)
      (interactive "sName: ")
      (ah:make-term name "bash"))

    ;; Needed to fix a terminal color bug - try removing?
    (defface term-color-black
      '((t (:foreground "#3f3f3f" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-red
      '((t (:foreground "#cc9393" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-green
      '((t (:foreground "#7f9f7f" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-yellow
      '((t (:foreground "#f0dfaf" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-blue
      '((t (:foreground "#6d85ba" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-magenta
      '((t (:foreground "#dc8cc3" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-cyan
      '((t (:foreground "#93e0e3" :background "#272822")))
      "Unhelpful docstring.")
    (defface term-color-white
      '((t (:foreground "#dcdccc" :background "#272822")))
      "Unhelpful docstring.")
    '(term-default-fg-color ((t (:inherit term-color-white))))
    '(term-default-bg-color ((t (:inherit term-color-black))))

    ;; ansi-term colors
    (setq ansi-term-color-vector
          [term term-color-black term-color-red term-color-green term-color-yellow
                term-color-blue term-color-magenta term-color-cyan term-color-white])

    ))

(use-package scala-mode2
  :commands scala-mode
  :defer t
  :mode (("\\.scala$" . scala-mode)
         ("\\.sbt$" . scala-mode)))

(use-package css-mode
  :commands css-mode
  :defer t
  :init
  (setq css-indent-offset 2))


(use-package sbt-mode
  :commands (sbt-find-definitions sbt-run-previous-command sbt-start)
  :init
  (setq sbt:program-name "/usr/local/bin/sbt"))

;; (use-package objc-mode
;;   :config
;;   (progn
;;     (defun ah:obj-editing ()
;;       (auto-complete-mode t)
;;       (setq indent-tabs-mode nil)
;;       (setq c-indent-level 4)
;;       (setq c-basic-offset 4))

;;     ;; Editing objc in a reasonable way...
;;     (setq objc-mode-hook 'ah:obj-editing)

;;     (add-to-list 'magic-mode-alist
;;                  `(,(lambda ()
;;                       (and (string= (file-name-extension buffer-file-name) "h")
;;                            (re-search-forward "@\\<interface\\>"
;;                                               magic-mode-regexp-match-limit t)))
;;                    . objc-mode))

;;     (setq cc-other-file-alist `(("\\.m$" (".h"))
;;                                 ("\\.h$" (".m"))))

;;     (add-hook 'c-mode-common-hook
;;               (lambda ()
;;                 (local-set-key (kbd "C-C o") 'ff-find-other-file)))))

;; (use-package multi-web-mode
;;   :config
;;   (progn
;;     (setq mweb-default-major-mode 'html-mode)
;;     (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                       (js-mode "<script type=\"text/javascript\"[^>]*>" "</script>")
;;                       (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;;     (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;     (multi-web-global-mode 1)))

;; (use-package java-mode
;;   :config
;;   (progn
;;     (c-add-style "adam-java-style"
;;                  '("java"
;;                    (c-basic-offset . 4)
;;                    (arglist-cont-nonempty . +)
;;                    (c-hanging-braces-alist
;;                     ((substatement-open)
;;                      (block-close . c-snug-do-while)
;;                      (extern-lang-open after)
;;                      (inexpr-class-open after)
;;                      (inexpr-class-close before)))
;;                    (c-offsets-alist
;;                     (substatement-open . 0))))

;;     (defun ah:java-mode-hook ()
;;       (remove-hook 'before-save-hook 'ah:cleanup-buffer-safe 'local)

;;       (c-set-style "adam-java-style")
;;       (c-set-offset 'arglist-cont-nonempty '+)
;;       (c-set-offset 'arglist-intro '+)
;;       (c-set-offset 'arglist-close 0)
;;       (c-set-offset 'statement-cont '+)
;;       (setq c-basic-offset 4
;;             tab-width 4
;;             indent-tabs-mode t))

;;     (add-hook 'java-mode-hook 'ah:java-mode-hook)))


(provide 'ah-modes)
