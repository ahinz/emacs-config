(ah/prepend-plugin-to-load-path "clojure-mode")

(require 'clojure-mode)
(require 'clojure-test-mode)

(setq nrepl-popup-stacktraces nil)

(add-hook 'clojure-mode-hook 'smartparens-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
