;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When debugging emacs problems, uncomment the following
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq debug-on-error 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Default packages to install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-packages '(ac-cider
                      auto-complete
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
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(put 'upcase-region 'disabled nil)

(remove-hook 'before-save-hook 'delete-trailing-whitespace)

;;(desktop-save-mode 1)

(add-to-list 'exec-path "/Users/mhalverson/bin")
;;"/usr/local/bin")
