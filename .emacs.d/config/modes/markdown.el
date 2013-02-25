(require 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun ah/markdown-mode-hook ()
  (setq fill-column 72)
  (auto-fill-mode t)
  (flyspell-mode t))

(add-hook 'markdown-mode-hook 'ah/markdown-mode-hook)
