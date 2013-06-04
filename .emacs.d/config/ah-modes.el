(defvar ah:mode-config-dir (concat user-emacs-directory "config/modes/"))

(defvar ah:modes
  (list "ace-jump"
        "expand-region"
        "emms"
        "vline"
        "change-inner"
        "clojure-preload" ;; nrepl and clojure helpfully
        "nrepl"           ;; depend on each other...?
        "clojure"
        "clojure-test"
        "erc"
        "flyspell"
        "full-ack"
        "haskell"
        "ibuffer"
        "ido"
        "iy-go-to-char"
        "jabber"
        "javap"
        "magit"
        "multiple-cursors"
        "multi-web"
        "objc"
        "package"
        "smartparens"
        "post"
        "rainbow-delimiters"
        "scala"
        "smex"
        "tempbuf"
        "yasnippet"
        "term"
        "yaml"
        "markdown"
        "js"
        "uniquify"))



(dolist (mode-config ah:modes)
  (when (not (file-directory-p mode-config))
    (load (concat ah:mode-config-dir mode-config ".el") nil nil t)))

(provide 'ah-modes)
