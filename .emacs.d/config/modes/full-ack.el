(ah/prepend-plugin-to-load-path "full-ack")

;; (autoload 'ack-same "full-ack" nil t)
;; (autoload 'ack "full-ack" nil t)
;; (autoload 'ack-find-same-file "full-ack" nil t)
;; (autoload 'ack-find-file "full-ack" nil t)

(require 'full-ack)

(setq ack-executable "/usr/bin/ack-grep")
