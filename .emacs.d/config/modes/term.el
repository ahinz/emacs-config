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

(add-hook 'term-mode-hook 'ah/turn-off-yas-minor-mode)

(open-term "tty0")
(open-term "tty1")
(open-term "tty2")
(open-term "tty3")
(open-term "tty4")
