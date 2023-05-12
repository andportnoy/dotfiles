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
 '(c-basic-offset 8)
 '(custom-enabled-themes '(wombat))
 '(enable-remote-dir-locals t)
 '(menu-bar-mode nil)
 '(org-agenda-files
   '("~/gtd/calendar.org" "/home/aportnoy/gtd/projects.org" "/home/aportnoy/gtd/actions.org"))
 '(org-capture-templates
   '(("j" "Journal entry" entry
      (file "~/org/journal.org")
      "* %T
%?")
     ("i" "GTD \"in\" item" entry
      (file "~/gtd/in.org")
      "* NEW %?")))
 '(org-startup-indented t)
 '(package-selected-packages
   '(racket-mode ein free-keys jupyter clang-format python-black vterm ## magit))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vterm-max-scrollback 100000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :height 120)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)

;; wrap text at 80 columns
(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

;; show column number
(setq column-number-mode t)

;; global org keys recommended in the compact guide
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(global-set-key (kbd "M-o") 'other-window)
(setq sentence-end-double-space nil)
(setq show-paren-delay 0)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(setq vterm-max-scrollback 100000)
(add-hook 'vterm-mode-hook
	  (lambda ()
	    (setq-local show-trailing-whitespace nil)))

(setenv "GPG_AGENT_INFO" nil)
(setq epa-pinentry-mode 'loopback)

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

; common lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")

(setq-default show-trailing-whitespace t)
(put 'scroll-left 'disabled nil)
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(toggle-frame-fullscreen)
