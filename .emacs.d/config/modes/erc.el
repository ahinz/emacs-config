;; Autojoin
;; (setq erc-auto-query 'bury)
(setq erc-auto-query 'buffer)

(setq erc-autojoin-channels-alist
       '(("azavea.com" "#azavea")
         ("freenode.net" "#okfn" "#scala" "#opentreemap" "#opendatacatalog" "#pycsw" "#geopython" "#geotrellis")))

(defun ah/default-erc ()
  (interactive)
  (let ((realpw (read-passwd "Bouncer Password: ")))
   (erc :server "www.adamhinz.com" :port 5123 :nick "adam" :password (concat "adammh:" realpw))
   (erc :server "www.adamhinz.com" :port 5123 :nick "adammh" :password (concat "adam:" realpw))))

(defun ah/erc-azavea ()
  (interactive)
  (erc :server "192.168.1.7" :port 6667 :nick "adam"))
