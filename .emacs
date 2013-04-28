(set-language-environment "utf-8")

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
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/backup"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; If emacs version more than "version", then do what you want
(defmacro emacs-more-than (version dosome)
  (if (string< version (substring (emacs-version) 10))
      dosome))

;; load-theme just support version 24
(emacs-more-than "24" (load-theme 'wombat t))

;; global-linum-mode just support version 23 and later
(emacs-more-than "23" (global-linum-mode t))

;; config for auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; highlight the match parenthesis when cursor on a parenthesis
(show-paren-mode t)
(setq show-paren-delay 0)
