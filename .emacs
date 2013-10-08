(set-language-environment "utf-8")

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
                         ("gnu"  . "http://elpa.gnu.org/packages/")
                         ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;;; add slime to load-path
(add-to-list 'load-path "/Applications/lispbox-0.7/slime/")

;;; Note that if you save a heap image, the character
;;; encoding specified on the command line will be preserved,
;;; and you won't have to specify the -K utf-8 any more.
;;(setq inferior-lisp-program "/Applications/lispbox-0.7/ccl/dx86cl64")

;; add all lisp implementations to slime
(setq slime-lisp-implementations
      '((clozurecl ("/Applications/lispbox-0.7/ccl/dx86cl64"))
        (CLISP ("/opt/local/bin/clisp"))
        (sbcl ("/opt/local/bin/sbcl"))))

(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)
(slime-setup '(slime-fancy))

;; set emacs backup to one directory
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs.d/backup"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; If emacs version more than "version", then do what you want
(defmacro emacs-more-than (version &rest dosome)
  (when (string< version (substring (emacs-version) 10))
    `(progn ,@dosome)))

;; load-theme just support version 24
(emacs-more-than "24" (load-theme 'wombat t))

;; global-linum-mode just support version 23 and later
(emacs-more-than "23" (global-linum-mode t))

;; config for auto-complete
(let ((ac-dir "~/.emacs.d/auto-complete/"))
  (add-to-list 'load-path ac-dir)
  (require 'auto-complete-config)
  (autoload 'auto-complete-mode "auto-complete-mode" t)
  (add-to-list 'ac-dictionary-directories (concat ac-dir "ac-dict"))
  (ac-config-default)
  (add-to-list 'ac-modes 'lisp-mode))

;; highlight the match parenthesis when cursor on a parenthesis
(show-paren-mode t)
(setq show-paren-delay 0)

;; hide welcome screen.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)

;; Semantic
(global-semantic-idle-completions-mode t)
(global-semantic-decoration-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-show-unmatched-syntax-mode t)

;; markdown mode
(add-to-list 'load-path "~/.emacs.d/markdown-mode/")
(autoload 'markdown-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))

;; lisp mode
(add-to-list 'auto-mode-alist '("\\.cl\\'". lisp-mode))

;; C/C++ indentation level
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil
              c-default-style "stroustrup")

;; basic initialization, (require) non-ELPA packages, etc.
(setq package-enable-at-startup nil)
(package-initialize)
;; (require) your ELPA packages, configure them as normal

;; set up undo-tree
(require 'undo-tree)		 
(global-undo-tree-mode)

;; enable desktop-save-mode
(require 'desktop)
(setq desktop-save-mode t)

;; storing/restoring the buffers/tabs (specifically elscreen tabs)
(require 'elscreen)
(elscreen-start)
(defvar emacs-configuration-directory "~/.emacs.d/"
  "The directory where the emacs configuration files are stored.")

(defvar elscreen-tab-configuration-store-filename
  (concat emacs-configuration-directory ".elscreen")
  "The file where the elscreen tab configuration is stored.")

(defun elscreen-store ()
  "Store the elscreen tab configuration."
  (interactive)
  (if (desktop-save emacs-configuration-directory)
      (with-temp-file elscreen-tab-configuration-store-filename
        (insert (prin1-to-string (elscreen-get-screen-to-name-alist))))))

(push #'elscreen-store kill-emacs-hook)

(defun elscreen-restore ()
  "Restore the elscreen tab configuration."
  (interactive)
  (if (desktop-read)
      (let ((screens (reverse
                      (read
                       (with-temp-buffer
                         (insert-file-contents elscreen-tab-configuration-store-filename)
                         (buffer-string))))))
        (while screens
          (setq screen (car (car screens)))
          (setq buffers (split-string (cdr (car screens)) ":"))
          (if (eq screen 0)
              (switch-to-buffer (car buffers))
            (elscreen-find-and-goto-by-buffer (car buffers) t t))
          (while (cdr buffers)
            (switch-to-buffer-other-window (car (cdr buffers)))
            (setq buffers (cdr buffers)))
          (setq screens (cdr screens))))))
;;(elscreen-restore);; This buffer is for notes you don't want to save, and for Lisp evaluation.

; let emacs shell load .bashrc file
(setq shell-command-switch "-ic")
