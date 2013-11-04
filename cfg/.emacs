(setq load-path (cons (expand-file-name "~/.emacs.d/danger-emacs") load-path))
(require 'danger-core)

;; I want /usr/local/bin/lein to be on my $PATH in emacs-shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; I already disabled the "C-z minimizes emacs" option.
(global-set-key [(control z)] 'undo)
