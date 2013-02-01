(defvar ah:defuns-dir (concat user-emacs-directory "defuns"))

(dolist (defuns (directory-files ah:defuns-dir t "\\w+"))
  (when (not (file-directory-p defuns))
    (load defuns nil nil t)))

(provide 'ah-defuns)
