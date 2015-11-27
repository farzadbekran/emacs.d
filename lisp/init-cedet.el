;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CEDET;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-file "~/.emacs.d/site-lisp/cedet-bzr/cedet-devel-load.el")
(load-file "~/.emacs.d/site-lisp/cedet-bzr/contrib/semantic-tag-folding.el")

(defun do-after-decorate ()
  "Fixes a bug with tagfolding."
  (global-semantic-tag-folding-mode t))

(add-hook 'semantic-decoration-mode-hook 'do-after-decorate)

(add-hook 'lisp-mode-hook
          (lambda ()
            (global-semantic-idle-summary-mode nil)))

(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
        global-semantic-idle-summary-mode
        global-semantic-tag-folding-mode
        global-semantic-idle-scheduler-mode
        global-semantic-decoration-mode
        global-semantic-highlight-func-mode
        global-semantic-mru-bookmark-mode
        global-cedet-m3-minor-mode
        global-semantic-idle-local-symbol-highlight-mode))

(semantic-mode)


(provide 'init-cedet)
