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
 '(package-selected-packages
   '(free-keys jupyter clang-format python-black vterm ## magit))
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

(global-set-key (kbd "M-o") 'other-window)
(setq sentence-end-double-space nil)
(setq show-paren-delay 0)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(setenv "GPG_AGENT_INFO" nil)
(setq epa-pinentry-mode 'loopback)

(defun switch-to-vterm ()
  (interactive)
  (if (string= (buffer-name) "*vterm*")
      (switch-to-buffer nil)
    (vterm)))
(global-set-key (kbd "M-[") 'switch-to-vterm)

(setq-default show-trailing-whitespace t)
(put 'scroll-left 'disabled nil)
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(toggle-frame-fullscreen)
