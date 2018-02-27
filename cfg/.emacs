;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When debugging emacs problems, uncomment the following
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq debug-on-error 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Default packages to install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-packages '(ac-cider
                      auto-complete
                      bash-completion
                      better-defaults
                      cider
                      cider-browse-ns
                      clojure-mode
                      dash
                      exec-path-from-shell
                      ;; desktop
                      ;; fringe-helper
                      ;; pkg-info
                      projectile
                      ))

;; (dolist (p my-packages)
;;   (unless (package-installed-p p)
;;     (package-install p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Danger stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons (expand-file-name "~/.emacs.d/danger-emacs") load-path))
(require 'danger-core)

(setq load-path (cons (expand-file-name "~/.emacs.d/exec-path-from-shell") load-path))
(require 'exec-path-from-shell)

;; I want /usr/local/bin/lein to be on my $PATH in emacs-shell.
(when (memq window-system '(mac ns))
  ;; This sets $MANPATH, $PATH, and exec-path from the shell.
  (exec-path-from-shell-initialize))
;;I want to copy other env vars
;;(exec-path-from-shell-copy-env "PYTHONPATH")

;; I want to be able to use "Apple H" to hide the window
(global-unset-key [(meta h)]) ;; but this isn't good enough :(

;; I want a SUPER key! (no need for a HYPER key yet)
(setq mac-option-modifier 'super) ;; sets the Option key to Super

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things from http://bzg.fr/emacs-strip-tease.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))
(set-frame-size-according-to-resolution)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

(fset 'three-column-disp
   [?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\M-x ?b ?a ?l ?a tab return ?\C-x ?2 ?\C-x ?o ?\C-x ?o ?\C-x ?o ?\C-x ?2])
(global-set-key (kbd "C-c 3") 'three-column-disp)
(fset 'two-one-one
   [?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\M-x ?b ?a ?l ?a ?n ?c ?e ?- tab return ?\C-x ?2])
(global-set-key (kbd "C-c 2") 'two-one-one)
(fset 'two-one
   "\C-x1\C-x3\C-x2")
(global-set-key (kbd "C-c 1") 'two-one)
(put 'three-column-disp 'kmacro t)
(put 'two-one-one 'kmacro t)
(put 'two-one 'kmacro t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; erc (irc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'erc)
;; (setq erc-hide-list '("JOIN" "PART" "QUIT"))
;; (setq erc-autojoin-channels-alist
;;       '(("freenode.net" "#clojure")
;;         ("freenode.net" "#leiningen")))

;; (defun erc-go ()
;;   (interactive)
;;   (erc :server "irc.freenode.net" :port 6667 :nick "mhalverson"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Things maybe to add.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I like abbreviations! "src/com/merced/" = "scm e" (without the space).
;; (setq default-abbrev-mode t)

;; This makes M-q awesome! Auto formatting of comments :D
(setq-default fill-column 79)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom set variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
	(("marmalade" . "http://marmalade-repo.org/packages/")
	 ("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa" . "http://melpa.milkbox.net/packages/")
	 ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(safe-local-variable-values
   (quote ((haskell-indent-spaces . 2)
           (hindent-style . "chris-done")
           (hindent-style . "gibiansky")
           (hindent-style . "johan-tibell")
           (haskell-process-type . cabal-repl)
           (shm-lambda-indent-style . leftmost-parent))))
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(put 'upcase-region 'disabled nil)

(remove-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'exec-path "/Users/mhalverson/bin")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom bindings
(global-set-key (kbd "s-j") 'scroll-up-line)
(global-set-key (kbd "s-k") 'scroll-down-line)


(defun string/starts-with (s begins)
      "Return non-nil if string S starts with BEGINS."
      (cond ((>= (length s) (length begins))
             (string-equal (substring s 0 (length begins)) begins))
            (t nil)))

(defun chomp-end (str)
      "Chomp tailing whitespace from STR."
      (replace-regexp-in-string (rx (* (any " \t\n")) eos)
                                ""
                                str))
(defun git-basedir ()
  (let* ((filename (buffer-file-name))
         (cmd (format "echo $(cd $(dirname %s) && git rev-parse --show-toplevel)" filename))
         (output (shell-command-to-string cmd)))
    (if (string/starts-with output "fatal:")
        nil
      (chomp-end output))))

(defun refresh-python-ctags ()
  (let ((base-dir (git-basedir)))
    (if base-dir
        (shell-command-to-string (format
                                  "echo $(cd %s && find . -name \"*.py\" -print | etags -)"
                                  base-dir))
      nil)))

(defun refresh-ctags ()
  (cond ((string= major-mode "python-mode")
         (refresh-python-ctags))
        (t "no-op")))

;; (add-hook 'before-save-hook 'refresh-ctags)
;; (setq tags-revert-without-query 1)
;; todo:
;; make it not ask you every single time if you want to use the new TAGS file
;;      Tags file <> has changed. Read new contents? (yes or no)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OS X El Capitan bug
(setq visible-bell nil) ;; The default
(setq ring-bell-function 'ignore)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Haskell
;; (require 'hi2)
(defun haskell-setup ()
  "Setup variables for editing Haskell files."
  (make-local-variable 'tab-stop-list)
  (setq tab-stop-list (number-sequence 2 80 2))
  (setq indent-line-function 'indent-relative)
  (haskell-indentation-mode)
  (haskell-indent -1)
  (haskell-simple-indent -1)
  )
(add-hook 'haskell-mode-hook 'haskell-setup)
(add-hook 'haskell-cabal-mode-hook 'haskell-setup)


(defun save-buffer-without-dtw ()
  (interactive)
  (let ((b (current-buffer)))   ; memorize the buffer
    (with-temp-buffer ; new temp buffer to bind the global value of before-save-hook
      (let ((before-save-hook (remove 'delete-trailing-whitespace before-save-hook)))
        (with-current-buffer b  ; go back to the current buffer, before-save-hook is now buffer-local
          (let ((before-save-hook (remove 'delete-trailing-whitespace before-save-hook)))
            (save-buffer)))))))
