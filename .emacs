(setq mac-command-modifier 'meta
      mac-option-modifier 'super)

(load-theme 'wombat)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "/opt/homebrew/bin/gpg")
 '(menu-bar-mode nil)
 '(org-agenda-files
   '("~/gtd/projects.org"))
 '(org-export-backends '(ascii html icalendar latex md confluence))
 '(org-goto-interface 'outline-path-completion)
 '(org-startup-indented t)
 '(package-selected-packages
   '(## clang-format eglot-booster free-keys imenu-list json-mode magit multi-vterm
	org-contrib racket-mode slurm-mode vterm vterm-toggle))
 '(package-vc-selected-packages
   '((eglot-booster :vc-backend Git :url
		    "https://github.com/jdtsmith/eglot-booster")))
 '(scroll-bar-mode nil)
 '(send-mail-function 'smtpmail-send-it)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vterm-max-scrollback 100000))

(defun ap/org-capture-hook ()
  (beginning-of-buffer)
  (forward-char 2)
  (insert "CLARIFY ")
  (end-of-buffer)
  (insert ":LOGBOOK:\n")
  (insert "- Filed ")
  (org-insert-timestamp (current-time) t t)
  (insert "\n")
  (insert ":END:"))

(setq org-capture-templates
      '(("j" "Journal entry" entry (file "~/org/journal.org") "* %T\12%?")
	("i" "GTD \"in\" item" entry (file "~/gtd/in.org") "* %?"
	 :prepare-finalize ap/org-capture-hook)))

(setq org-log-into-drawer t)
(setq org-agenda-breadcrumbs-separator "/")

;;(setq org-agenda-prefix-format
;;      (cons `(todo . ,(concat " %i %-12:c%b\n" (make-string 16 ? )))
;;	    org-agenda-prefix-format))

(with-eval-after-load 'org-agenda
  (setq org-agenda-prefix-format
	(cons `(todo . "%b\n  ")
	      org-agenda-prefix-format)))

;; treesitter grammars
;; https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(c "https://github.com/tree-sitter/tree-sitter-c")
	(cpp "https://github.com/tree-sitter/tree-sitter-cpp")
	(llvm "https://github.com/benwilliamgraham/tree-sitter-llvm")))

;; override regular modes with treesitter-based modes
(setq major-mode-remap-alist
      '((bash-mode . bash-ts-mode)
	(python-mode . python-ts-mode)
	(c-mode . c-ts-mode)
	(c++-mode . c++-ts-mode)))

(defun prepend-google-c++-indent-rules ()
  "Insert extra Treesitter indentation rules for C++ using Google style"
  (let ((rules (alist-get 'cpp treesit-simple-indent-rules))
        (extra-rules
         '(
           ;; When debugging/improving this, it helps to:
           ;; 1. Enable treesit-inspect-mode. This shows the current syntax
           ;;    structure in the modeline.
           ;; 2. Enable treesit-explore-mode. This shows the syntax tree in a
           ;;    separate buffer. You can click nodes in the explore buffer and
           ;;    they will get highlighted in the source buffer.
           ;; 3. Set treesit--indent-verbose to non-nil. This prints the rule
           ;;    that got matched in the echo.
           ;; 4. Run treesit-check-indent in a buffer that is known to be
           ;;    indented correctly. This shows the diff between the buffer and
           ;;    how treesitter would indent it using the specified mode.

           ;; Don't indent inside a namespace. This n-p-gp pattern is superior
           ;; to what is done by default because it matches namespaces
           ;; specifically, and not just all declaration_list's.
           ((n-p-gp nil "declaration_list" "namespace_definition") parent-bol 0)

           ;; If the parameter is the first parameter and it begins a new line,
           ;; indent with 4 spaces.
           ;;
           ;; The "match" example in the manual seems to be wrong since it lists
           ;; 6 arguments instead of 5 and also 0-0 seems to exclude the first
           ;; argument. Actually I'm wrong because the first child of a
           ;; parameter list is "(", the opening parenthesis. So the first
           ;; parameter is going to have index 1.
           ((match nil "parameter_list" nil 1 1) parent-bol 4)
           ;; If the parameter is not the first parameter and it begins a new
           ;; line, indent at the same level as the first parameter.
           ((match nil "parameter_list" nil 2 999) (nth-sibling 1) 0)
           ((match nil "argument_list" nil 1 1) parent-bol 4)
           ((match nil "argument_list" nil 2 999) (nth-sibling 1) 0)
           ((node-is "field_initializer_list") parent-bol 4)
           ((node-is "field_initializer") (nth-sibling 1) 0)
           ;; public, protected, private indented with 1 space
           ((node-is "access_specifier") parent-bol 1)
           ;; TODO figure out what's going on when there's a comment between the
           ;; "=" and the initializer, treesitter seems to populate the value
           ;; field with just the comment...
           ;; Grammar for the value field:
           ;; https://github.com/tree-sitter/tree-sitter-cpp/blob/a71474021410973b29bfe99440d57bcd750246b1/src/grammar.json#L3584-L3600
           ((match nil "init_declarator" "value" 0 999) parent-bol 4)
           ;; Not beginning of line where parent is, but of parent itself
           ((match nil "assignment_expression" "right" 0 999) parent 4)
           ;; TODO align multiline chains of operators like <<
           ((parent-is "init_declarator") prev-sibling 0)
           ((match nil "initializer_list" nil 1 1) parent-bol 4)
           ((node-is "case") parent-bol 2)
           )))
    (let ((new-rules (append extra-rules rules)))
      (setq-local treesit-simple-indent-rules `((cpp . ,new-rules))))))

(setq indent-tabs-mode nil)
(add-hook 'c++-ts-mode-hook 'prepend-google-c++-indent-rules)
(add-hook 'c++-ts-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'c-ts-mode-hook (lambda () (setq indent-tabs-mode nil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :height 140)

;; wrap text at 80 columns
(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

;; show column number
(setq column-number-mode t)

;; global org keys recommended in the compact guide
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;; shortcut equivalent to C-c c i
(global-set-key (kbd "C-c i") (lambda () (interactive) (org-capture nil "i")))
(bind-keys*
     ("M-o" . other-window)
     ("M-O" . (lambda () (interactive) (other-window -1))))
(add-hook 'org-mode-hook
	  (lambda () (auto-fill-mode 0)))
(add-hook 'org-mode-hook
	  (lambda () (visual-line-mode 1)))

(setq org-log-refile 'time)
(setq org-refile-use-outline-path 'file)
(setq org-refile-targets
      '((("in.org" "trash.org" "done.org" "someday.org") . (:level . 0))
	(("projects.org") . (:maxlevel . 9))))
;;(global-set-key (kbd "M-o") 'other-window)
;;(global-set-key (kbd "M-O") '(lambda () (interactive) (other-window -1)))
(setq sentence-end-double-space nil)
(setq show-paren-delay 0)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(setq vterm-max-scrollback 100000)
(add-hook 'vterm-mode-hook
	  (lambda ()
	    (setq-local show-trailing-whitespace nil)))

;; snappier vterm, default is 0.1 and feels laggy
;; nil would be extreme
(setq vterm-timer-delay 0.01)

(use-package vterm
  :config
  (add-to-list 'vterm-tramp-shells
	       '("docker" "/bin/bash"))
  (add-to-list 'vterm-tramp-shells
	       '("ssh" "/bin/bash"))
  (add-to-list 'vterm-tramp-shells
	       '("scp" "/bin/bash")))

(setenv "GPG_AGENT_INFO" nil)
(setq epa-pinentry-mode 'loopback)

;; https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
;; (setq vc-ignore-dir-regexp
;;       (format "\\(%s\\)\\|\\(%s\\)"
;;               vc-ignore-dir-regexp
;;               tramp-file-name-regexp))
(setq remote-file-name-inhibit-locks t)
;; Tramp invokes /bin/bash with -norc which helps prevent shell config script in
;; Docker containers from clobbering PS1 which Tramp sets to a very specific
;; value. If this value is clobbered, Tramp goes into an infinite loop waiting
;; for it to show up.
;; /bin/sh -norc should also work but I don't know how to pass that extra arg.
;; https://github.com/emacs-mirror/emacs/blob/f283144658259f209efdef78c576b43832c9c479/lisp/net/tramp.el#L6043-L6050
(add-to-list 'tramp-connection-properties
             (list nil "remote-shell" "/bin/bash"))

;; process-file-shell-command resets the shell using
;; with-connection-local-variables, so I think I also need the below
;; to counteract that
(connection-local-set-profile-variables
 'sane-remote
 '((shell-file-name . "/bin/bash")
   ;; this prevents Tramp from deviating from the default remote path
   (tramp-remote-path . (tramp-own-remote-path))))

(connection-local-set-profiles nil 'sane-remote)

;; this prevents tramp from clobbering remote PATH
;; https://stackoverflow.com/questions/26630640/tramp-ignores-tramp-remote-path#26649558
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; Tramp hardcodes PAGER=cat for whatever reason, but we want less
(setq vterm-environment
      (append vterm-environment '("PAGER=less" "EDITOR=vim")))

(setq vc-handled-backends nil)

;; importantly, dir local variables are disabled in remote directories by default
;; otherwise there's a big perf penalty

;; this speeds up Python browsing + file opening experience
(global-eldoc-mode -1)

(defun switch-to-vterm ()
  (interactive)
  (if (string= (buffer-name) "*vterm*")
      (switch-to-buffer (other-buffer (current-buffer) t))
    (vterm)))
(global-set-key (kbd "M-[") 'switch-to-vterm)

(defun switch-to-notes ()
  (interactive)
  (if (string= (buffer-name) "log.org")
      (switch-to-buffer (other-buffer (current-buffer) t))
    (find-file "~/log.org")))
(global-set-key (kbd "M-]") 'switch-to-notes)

(defun ifdef-surround-region (a b v)
  "Surround the region defined by A and B with #ifdef V/#endif directives."
  (interactive (list (region-beginning)
		     (region-end)
		     (let ((default "DEBUG"))
		       (read-string
			(format "Variable (default %s): " default) nil nil default))))
  (save-excursion
    (goto-char a)
    (beginning-of-line)
    (insert (format "#ifdef %s\n" v))
    (goto-char b)
    (beginning-of-line 2)
    (insert "#endif\n")))

; pull man pages from remote machine if needed
(setq-default Man-support-remote-systems t)

; scheme
(setq scheme-program-name "csi")

(setq inferior-lisp-program "/usr/bin/sbcl")

(setq-default show-trailing-whitespace t)
(put 'scroll-left 'disabled nil)
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(use-package eglot
  :config
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eglot-extend-to-xref t)
)

;; note this requires emacs-lsp-booster locally or on the remote host
;; (use-package eglot-booster
;;   :after eglot
;;   :config (eglot-booster-mode))


(add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
;; (windmove-default-keybindings)
(winner-mode)
(setq frame-resize-pixelwise t)

(setq gnus-select-method
      '(nnimap "fastmail"
	       (nnimap-address "imap.fastmail.com")
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))


(toggle-frame-fullscreen)
