(defun ah:enable-infinity ()
  (interactive)
  (font-lock-add-keywords
   'clojure-mode `(("\\(nil\\)"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) ?∞)
                              nil))))))

(defun ah:cleanup-buffer-safe ()
  (interactive)
  (if (not (or (string= major-mode 'makefile-gmake-mode)
               (string= major-mode 'makefile-mode)
               (string= major-mode 'java-mode)))
      (untabify (point-min) (point-max)))
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))

(defun to-webm (lat lng)
  (let ((origin-shift (/ (* 2.0 pi (/ 6378137.0 2.0)) 180.0)))
    (list
     (* origin-shift lng)
     (* origin-shift
        (/ (log (tan (*
                      (+ 90.0 lat)
                      (/ pi 360.0))))
                (/ pi 180.0))))))

(defun to-latlng (x y)
  (let ((origin-shift (/ (* 2.0 pi (/ 6378137.0 2.0)) 180.0))
        (d2r (/ pi 180.0))
        (r2d (/ 180.0 pi)))
    (list
     (* r2d (-
             (* 2.0 (atan (exp (* d2r (/ y origin-shift)))))
             (/ pi 2.0)))
     (/ x origin-shift))))

(defun bbox-to-polylist (xmin ymin xmax ymax)
  `((,xmin ,ymin)
    (,xmin ,ymax)
    (,xmax ,ymax)
    (,xmax ,ymin)
    (,xmin ,ymin)))

(defun bbox-to-wkt (xmin ymin xmax ymax)
  (format "POLYGON ((%s))"
          (mapconcat 'identity
                     (mapcar (lambda (z) (format "%f,%f" (first z) (second z)))
                             (bbox-to-polylist xmin ymin xmax ymax))
                     " ")))

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun ah:default-erc ()
  (interactive)
  (let ((realpw (get-string-from-file "~/.emacs.d/.erc-info")))
    (erc :server "www.adamhinz.com" :port 5123 :nick "adammh" :password (concat "adam:" realpw))))

(defun ah:print-bw ()
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

(defun ah:start-repl ()
  (interactive)
  (setq default-directory "/home/adam/src/zensight/server/")
  (start-process "repl" "**repl**" "lein" "with-profiles" "+product" "repl" ":headless" ":port" "44553"))

(provide 'ah-tools)
