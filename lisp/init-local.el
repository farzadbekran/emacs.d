;;; package --- summarry
;;; This is my personal configs from the old .emacs file

(eval-after-load 'flycheck '(flycheck-clojure-setup))
(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))

;;; Code:

(add-hook 'clojure-mode-hook
          (lambda ()
            ;; this fixes indentations for compojure routes
            (define-clojure-indent
              (defroutes 'defun)
              (GET 2)
              (POST 2)
              (PUT 2)
              (DELETE 2)
              (HEAD 2)
              (ANY 2)
              (context 2))))

;;(setq split-height-threshold nil)
;;(setq split-width-threshold 80)

(require 'auto-complete)

(add-hook 'nrepl-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-repl-mode-hook 'auto-complete-mode)
(add-hook 'nrepl-repl-mode-hook 'paredit-mode)

(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "<C-backspace>")
              'backward-kill-sexp)
            (define-key cider-mode-map (kbd "<C-delete>")
              'kill-sexp)))

(add-hook 'nrepl-repl-mode-hook
          (lambda ()
            (define-key nrepl-repl-mode-map (kbd "<C-backspace>")
              'backward-kill-sexp)
            (define-key nrepl-repl-mode-map (kbd "<C-delete>")
              'kill-sexp)))

(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)
(setq cider-repl-display-in-current-window t)
(setq cider-prompt-save-file-on-load nil)

(add-hook 'nrepl-repl-mode-hook
          (lambda ()
            (define-key nrepl-repl-mode-map (kbd "<return>") 'nrepl-return)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FIX SUBS;;;;;;;;;;;;;;;;;;;;;;;;
(defun fix-subtitle ()
  "Fix persian subtitles that lose encoding info."
  (interactive)
  (recode-region (buffer-end -1) (buffer-end 1) 'windows-1256 buffer-file-coding-system)
  (set-buffer-file-coding-system 'utf-8-unix)
  (save-buffer))

(global-set-key (kbd "<C-f12>") 'fix-subtitle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SLIME;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load "hyperspec.el"
  (setq common-lisp-hyperspec-root "file:///home/farzad/Documents/HyperSpec/"))

(defun fix-lisp-commands ()
  "Fixes my favorite Lisp shortcuts in Lisp related modes."
  (setq lisp-indent-function 'common-lisp-indent-function)
  (define-key slime-mode-map (kbd "<return>")
    'newline-and-indent)
  (define-key slime-mode-map (kbd "<C-backspace>")
    'backward-kill-sexp)
  (define-key slime-mode-map (kbd "<C-delete>")
    'kill-sexp)

  (define-key slime-repl-mode-map (kbd "<C-backspace>")
    'backward-kill-sexp)
  (define-key slime-repl-mode-map (kbd "<C-delete>")
    'kill-sexp)

  (define-key emacs-lisp-mode-map (kbd "<return>")
    'newline-and-indent)
  (define-key emacs-lisp-mode-map (kbd "<C-backspace>")
    'backward-kill-sexp)
  (define-key emacs-lisp-mode-map (kbd "<C-delete>")
    'kill-sexp))

(add-hook 'slime-mode-hook 'fix-lisp-commands)
(add-hook 'slime-repl-mode-hook 'fix-lisp-commands)
(add-hook 'emacs-lisp-mode 'fix-lisp-commands)
(add-hook 'lisp-mode 'fix-lisp-commands)
(global-set-key "\C-c\C-s" 'slime-selector)

(add-hook 'slime-mode-hook
          (lambda ()
            ;; (unless (slime-connected-p)
            ;;   (save-excursion (slime)))
            (slime-setup '(slime-repl))
            (slime-setup '(slime-asdf))
            (slime-setup '(slime-autodoc))
            (slime-setup '(slime-fuzzy))
            (slime-setup '(slime-editing-commands))
            (slime-setup '(slime-presentations))
            (slime-setup '(slime-references))
            (slime-setup '(slime-xref-browser))
            (slime-setup '(slime-fancy-inspector))
            (slime-setup '(slime-tramp))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;STAY ON TOP;;;;;;;;;;;;;;;;;;;;;;
(auto-raise-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;CIDER INSPECT;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'cider-inspect)

;;(add-hook 'nrepl-repl-mode-hook
;;          (lambda ()
;;            (define-key nrepl-repl-mode-map (kbd "<f1>") 'cider-inspect)))

;;(add-hook 'cider-repl-mode-hook
;;          (lambda ()
;;            (define-key cider-repl-mode-map (kbd "<f1>") 'cider-inspect)))

;;;;;;;;;;;;;;;;;;;;;;;;;AUTO-COMPLETE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun setup-ac-keys ()
  (define-key ac-completing-map "\t" 'ac-complete)
  (define-key ac-completing-map "\r" 'ac-complete))

(add-hook 'ac-mode-hook 'setup-ac-keys)

(global-set-key (kbd "<f11>") 'auto-complete-mode)

(setq-default ac-sources '(ac-source-semantic-raw
                           ac-source-semantic
                           ac-source-abbrev
                           ac-source-dictionary))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;C-mode;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-c-hook ()
  "Customize things for c buffers."
  (local-set-key (kbd "RET") 'newline-and-indent)
  (semantic-tag-folding-mode)
  (linum-mode t)
  (flycheck-mode -1))

(setq c-mode-hook 'my-c-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;; ELSCREEN ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(elscreen-start)
(global-set-key (kbd "<C-tab>") 'elscreen-next)
(global-set-key "\C-z\C-z" 'delete-other-windows)

;;;;;;;;;;;;;;;;;;;;;;;;;;; ORG MODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'org-mode-hook
          (lambda ()
            (global-set-key (kbd "<C-tab>") 'elscreen-next)
            (define-key org-mode-map (kbd "<C-tab>") 'elscreen-next)
            (define-key org-agenda-mode-map (kbd "<C-tab>") 'elscreen-next)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WIND-MOVE;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;windmove messes these up -.-

(global-set-key (vector (list 'control 'down)) 'forward-paragraph)
(global-set-key (vector (list 'control 'up)) 'backward-paragraph)
(global-set-key (vector (list 'control 'left)) 'left-word)
(global-set-key (vector (list 'control 'right)) 'right-word)

(windmove-default-keybindings 'alt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TOGGLE-FULLSCREEN;;;;;;;;;;;;;;;;;;;;
(global-set-key [(meta return)] 'toggle-frame-fullscreen)
(tool-bar-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PAREDIT;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun setup-paredit-keys ()
  (define-key paredit-mode-map (kbd "C-<left>")
    'paredit-backward)
  (define-key paredit-mode-map (kbd "C-<right>")
    'paredit-forward)
  (define-key paredit-mode-map (kbd "M-<down>")
    'windmove-down)
  (define-key paredit-mode-map (kbd "M-<up>")
    'windmove-up)
  (define-key paredit-mode-map [kp-right]
    'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map [kp-left]
    'paredit-backward-slurp-sexp))

(global-set-key [f12] 'paredit-mode)

(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(add-hook 'paredit-mode-hook 'setup-paredit-keys)

;;;;;;;;;;;;;;;;;;;;SETUP FILE NAME TRANSLATOR FOR REMOTE HOST;;;;;;;
;; (add-hook 'slime-connected-hook
;;           (lambda ()
;;             (push (list ".*"
;;                         (lambda (filename)
;;                           filename)
;;                         (lambda (filename)
;;                           filename))
;;                   slime-filename-translations)
;;             (push (list "lisper"
;;                         (lambda (filename)
;;                           (subseq filename (length "/ssh:root@lisper.ir:")))
;;                         (lambda (filename)
;;                           (concat "/ssh:root@lisper.ir:" filename)))
;;                   slime-filename-translations)
;;             (push (slime-create-filename-translator :machine-instance "lisper.ir"
;;                                                     :remote-host "lisper"
;;                                                     :username "root")
;;                   slime-filename-translations)))

;; (push (slime-create-filename-translator :machine-instance "lisper.ir"
;;                                      :remote-host "lisper"
;;                                      :username "root")
;;       slime-filename-translations)

;;;;;;;;;;;;;;;;;;;;;;;COLUMN MARKER;;;;;;;;;;;;;;;;;;;
(require 'column-marker)
(add-hook 'clojure-mode-hook (lambda () (interactive) (column-marker-1 80)))

;;; Commentary:
(provide 'init-local)
;;; init-local.el ends here
