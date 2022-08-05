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
 '(column-number-mode t)
 '(custom-enabled-themes '(wombat))
 '(global-auto-revert-mode t)
 '(package-selected-packages '(## magit))
 '(scroll-bar-mode nil)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :height 150)
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
(setq tramp-verbose 3)

;; wrap text at 80 columns
(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(global-set-key (kbd "M-o") 'other-window)
(setq sentence-end-double-space nil)
(setq show-paren-delay 0)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(setq-default show-trailing-whitespace t)
