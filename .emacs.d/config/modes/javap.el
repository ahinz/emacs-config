;; -*- coding: utf-8 -*-
(ah/prepend-plugin-to-load-path "javap-mode")

(require 'javap-mode)
(add-to-list 'auto-mode-alist '("\\.class$" . javap-mode))
