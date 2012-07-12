(defun ah/mark-objc-method ()
  "Mark an objc method"
  (interactive)
  (let ((objc-method-regexp "-[ ]*("))
    (search-backward-regexp objc-method-regexp))
  (set-mark (point))
  (end-of-defun)
  (exchange-point-and-mark))

(defun ah/mark-objc-toplevel ()
  "Mark an objective top level @interface, @implementation"
  (interactive)
  (search-backward-regexp "\\(@implementation\\)\\|\\(@interface\\)")
  (set-mark (point))
  (search-forward-regexp "@end")
  (exchange-point-and-mark))

(defun ah/add-objc-mode-expansions ()
  (interactive)
  (set (make-local-variable 'er/try-expand-list)
       (setq er/try-expand-list '(er/mark-word
                                  er/mark-symbol
                                  er/mark-symbol-with-prefix
                                  er/mark-next-accessor
                                  er/mark-comment
                                  er/mark-comment-block
                                  er/mark-inside-quotes
                                  er/mark-outside-quotes
                                  er/mark-inside-pairs
                                  er/mark-outside-pairs
                                  ah/mark-objc-method
                                  ah/mark-objc-toplevel))))


(add-hook 'objc-mode-hook 'ah/add-objc-mode-expansions)

(provide 'objc-mode-expansions)
