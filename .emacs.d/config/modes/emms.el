(ah/prepend-plugin-to-load-path "emms/lisp")
(require 'emms-setup)

(emms-devel)
(emms-default-players)

(setq emms-source-file-directory "~/music/artists")
(setq emms-source-file-default-directory "~/music/artists")

(emms-browser-make-filter
 "all"
 (lambda (track)
   (or
    (funcall (emms-browser-filter-only-type 'file) track)
    ;; ignore the pending directory
    (not (funcall
          (emms-browser-filter-only-dir "~/music/artists") track)))))

(require 'emms-info-mp3info)
(add-to-list 'emms-info-functions 'emms-info-mp3info)

(setq later-do-interval 0.001
      emms-info-asynchronously nil)

(setq emms-mode-line-format "")
