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

;; show line numbers
(global-linum-mode t)

;;set color theme
(load-theme 'wombat t)
