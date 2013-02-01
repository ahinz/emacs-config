(defvar ah:mode-config-dir (concat user-emacs-directory "config/modes/"))

(defvar ah:modes 
  (list "ace-jump"
        "expand-region"
        "change-inner"
        "clojure"
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
        "nrepl"
        "objc"
        "package"
        "paredit"
        "post"
        "rainbow-delimiters"
        "scala"
        "smex"
        "tempbuf"
        "term"
        "yaml"
        "js"
        "yasnippet"))

  

(dolist (mode-config ah:modes)
  (when (not (file-directory-p mode-config))
    (load (concat ah:mode-config-dir mode-config ".el") nil nil t)))

(provide 'ah-modes)
