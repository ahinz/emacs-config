(defun ah/cleanup-buffer-safe ()
  (interactive)
  (if (not (or (string= major-mode 'makefile-gmake-mode)
               (string= major-mode 'makefile-mode)))
      (untabify (point-min) (point-max)))
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))


;; When popping the mark, continue popping until the cursor actually moves
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))


;; Various superfluous white-space. Just say no.
(add-hook 'before-save-hook 'ah/cleanup-buffer-safe)

(defun ugh-makefile-hook ()
  (remove-hook 'before-save-hook 'ah/cleanup-buffer-safe 'local))

(c-add-style "adam-java-style" '("java"
                               (c-basic-offset . 4)
                               (arglist-cont-nonempty . +)
                               (c-hanging-braces-alist
                                ((substatement-open)
                                 (block-close . c-snug-do-while)
                                 (extern-lang-open after)
                                 (inexpr-class-open after)
                                 (inexpr-class-close before)))
                               (c-offsets-alist
                                (substatement-open . 0))))
(defun java-mode-hook ()  
  (remove-hook 'before-save-hook 'ah/cleanup-buffer-safe 'local)

  (c-set-style "adam-java-style")
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'statement-cont '+)
  (setq c-basic-offset 4
        tab-width 8
        indent-tabs-mode t))

(add-hook 'makefile-mode-hook 'ugh-makefile-hook)
(add-hook 'java-mode-hook 'java-mode-hook)
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


(provide 'gis)
