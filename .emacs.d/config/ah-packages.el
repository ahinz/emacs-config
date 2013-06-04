
(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)


(defvar ah/base-packages
  '(ace-jump-mode auto-complete clojure-mode clojure-test-mode clojurescript-mode ac-nrepl
    expand-region full-ack haskell-mode iy-go-to-char jabber js2-mode magit markdown-mode
    nrepl multiple-cursors smartparens rainbow-delimiters smex yasnippet yaml-mode vline magithub
    popup)
  "Package list")

(defun ah/base-packages-p ()
   (loop for p in ah/base-packages
         when (not (package-installed-p p)) do (return nil)
         finally (return t)))

(defun ah/install-packages ()
  (unless (ah/base-packages-p)
    ;; check for new packages (package versions)
    (message "%s" "Refreshing refreshing package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p ah/base-packages)
      (when (not (package-installed-p p))
        (package-install p)))))

(package-initialize)
(ah/install-packages)

(provide 'ah-packages)
