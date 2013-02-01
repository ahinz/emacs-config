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
