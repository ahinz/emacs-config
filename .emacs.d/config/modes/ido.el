;; -*- coding: utf-8 -*-

(when (require 'ido "ido" t)
  (ido-mode t)
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-virtual-buffers t))

;; Don't randomly switch my ido buffer lists
(setq ido-auto-merge-delay-time 99999)
