(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(wombat))
 '(enable-remote-dir-locals t)
 '(epg-gpg-program "/opt/homebrew/bin/gpg")
 '(exec-path
   '("/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin"
     "/Applications/Emacs.app/Contents/MacOS/bin-arm64-11"
     "/Applications/Emacs.app/Contents/MacOS/libexec-arm64-11"
     "/Applications/Emacs.app/Contents/MacOS/libexec" "/opt/homebrew/bin/"))
 '(menu-bar-mode nil)
 '(org-agenda-files
   '("~/gtd/calendar.org" "/home/aportnoy/gtd/projects.org"
     "/home/aportnoy/gtd/actions.org"))
 '(org-capture-templates
   '(("j" "Journal entry" entry (file "~/org/journal.org") "* %T\12%?")
     ("i" "GTD \"in\" item" entry (file "~/gtd/in.org") "* NEW %?")))
 '(org-export-backends '(ascii html icalendar latex md confluence))
 '(org-goto-interface 'outline-path-completion)
 '(org-startup-indented t)
 '(package-selected-packages
   '(## clang-format eglot ein free-keys imenu-list jupyter lsp-mode magit
	multi-vterm org-contrib ox-slack python-black racket-mode vterm
	vterm-toggle yaml-mode))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vterm-max-scrollback 100000))

;; treesitter grammars
;; https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(c "https://github.com/tree-sitter/tree-sitter-c")
	(cpp "https://github.com/tree-sitter/tree-sitter-cpp")))

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

(add-hook 'c++-ts-mode-hook 'prepend-google-c++-indent-rules)

;; pylsp, maybe other stuff
(setenv "PATH"
        (concat
         (getenv "PATH")
	 path-separator "~/.local/bin"))

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
(bind-keys*
     ("M-o" . other-window)
     ("M-O" . (lambda () (interactive) (other-window -1))))
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
;; limit VC backends to Git to speed up Tramp checks
(setq vc-handled-backends '(Git))

(defun switch-to-vterm ()
  (interactive)
  (if (string= (buffer-name) "*vterm*")
      (switch-to-buffer (other-buffer (current-buffer) t))
    (vterm)))
(global-set-key (kbd "M-[") 'switch-to-vterm)

(defun switch-to-notes ()
  (interactive)
  (if (string= (buffer-name) "notes.org")
      (switch-to-buffer (other-buffer (current-buffer) t))
    (switch-to-buffer "notes.org")))
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

(add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
;; (windmove-default-keybindings)
(winner-mode)
(toggle-frame-fullscreen)
