(setq load-path (cons (expand-file-name "~/.emacs.d/danger-emacs") load-path))
(require 'danger-core)

(setq load-path (cons (expand-file-name "~/.emacs.d/exec-path-from-shell") load-path))
(require 'exec-path-from-shell)

;; I want /usr/local/bin/lein to be on my $PATH in emacs-shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; I already disabled the "C-z minimizes emacs" option.
(global-set-key [(control z)] 'undo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things from home
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\M-[" 'shrink-window)
(global-set-key "\M-]" 'enlarge-window-horizontally)

;; I like knowing where the 80th column is.
(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))
(require 'column-marker)
(add-hook 'after-change-major-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; I like knowing what line I'm on.
(set-face-background 'highlight "gray74")
(add-hook 'after-change-major-mode-hook (lambda () (hl-line-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things maybe to add.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I like abbreviations! "src/com/merced/" = "scm e" (without the space).
;; (setq default-abbrev-mode t)
