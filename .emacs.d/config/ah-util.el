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
