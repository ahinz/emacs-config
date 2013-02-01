(add-to-list 'custom-theme-load-path "~/.emacs.d/site-lisp/tomorrow-theme")

(load-theme 'tomorrow-night-bright t)

;; Fixes an issue with tomorrow-night-bright theme
(setq ansi-term-color-vector
  [term-face
   term-color-black
   term-color-red
   term-color-green
   term-color-yellow
   term-color-blue
   term-color-magenta
   term-color-cyan
   term-color-white])

(provide 'ah-theme)
