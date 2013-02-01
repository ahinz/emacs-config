;; -*- coding: utf-8 -*-
(ah/prepend-plugin-to-load-path "yaml-mode")

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
