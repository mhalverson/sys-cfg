(setq load-path (cons (expand-file-name "~/.emacs.d/danger-emacs") load-path))
(require 'danger-core)

(setq load-path (cons (expand-file-name "~/.emacs.d/exec-path-from-shell") load-path))
(require 'exec-path-from-shell)

;; I want /usr/local/bin/lein to be on my $PATH in emacs-shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; I want to be able to use "Apple H" to hide the window
(global-unset-key [(meta h)]) ;; but this isn't good enough :(


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
;;(set-frame-size-according-to-resolution)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; See http://bzg.fr/emacs-hide-mode-line.html
(defvar-local hidden-mode-line-mode nil)
(defvar-local hide-mode-line nil)
(define-minor-mode hidden-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global nil
  :variable hidden-mode-line-mode
  :group 'editing-basics
  (if hidden-mode-line-mode
      ;; rotatef will swap the values of the two args
      (rotatef hide-mode-line mode-line-format)
    (rotatef mode-line-format hide-mode-line))
  (when (and (called-interactively-p 'interactive)
             hidden-mode-line-mode)
    (run-with-idle-timer
     0 nil 'message
     (concat "Hidden Mode Line Mode enabled.  "
             "Use M-x hidden-mode-line-mode RET to make the mode-line appear."))))
;; Activate hidden-mode-line-mode globally
;;(add-hook 'prog-mode-hook #'hidden-mode-line-mode)

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
;; Things from home
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I like knowing where the 80th column is.
(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))
;;(require 'column-marker)
;;(add-hook 'after-change-major-mode-hook (lambda () (interactive) (column-marker-1 80)))

(require 'erc)
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#clojure")
        ("freenode.net" "#leiningen")))

(defun erc-go ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "mhalverson"))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(dta-default-cfg "desktopaid.conf")
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
