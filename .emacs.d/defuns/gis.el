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
