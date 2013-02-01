(defvar ah:plugin-path "~/.emacs.d/plugins/" "Path to the plugins folder")

(defun ah/prepend-to-load-path (path)
  (add-to-list 'load-path path))

(defun ah/prepend-plugin-to-load-path (path)
  (ah/prepend-to-load-path (concat ah:plugin-path path)))

(ah/prepend-to-load-path ah:plugin-path)

(provide 'ah-util)