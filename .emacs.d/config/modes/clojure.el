(ah/prepend-plugin-to-load-path "clojure-mode")

(require 'clojure-mode)
(require 'clojure-test-mode)

(setq nrepl-popup-stacktraces nil)

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
