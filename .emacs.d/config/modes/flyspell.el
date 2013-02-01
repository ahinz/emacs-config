;; Use aspell instead of ispell (how well do uspell?)
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra")) ;; Note: could use fast or normal but results in degraded performance
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;(flyspell-incorrect ((t (:foreground "red" :underline t :weight bold))))
