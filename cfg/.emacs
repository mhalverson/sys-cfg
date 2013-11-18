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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things maybe to add.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I like abbreviations! "src/com/merced/" = "scm e" (without the space).
;; (setq default-abbrev-mode t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Kibit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

(defun kibit-current-file ()
  "Run kibit on the current file.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile (concat "lein kibit " buffer-file-name)))
