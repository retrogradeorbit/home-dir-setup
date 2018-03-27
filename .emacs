;; emacs config file

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; expand-region
(require 'expand-region)
(global-set-key (kbd"C-=") 'er/expand-region)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; magit
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

(load-theme 'zenburn t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(ido-mode 1)
(global-linum-mode 1)
(delete-selection-mode 1)

;; no tabs by default. modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)

;; if indent-tabs-mode is off, untabify before saving
;; (add-hook 'before-save-hook
;;           (lambda () (if (not indent-tabs-mode)
;;                          (untabify (point-min) (point-max)))))

(add-hook 'before-save-hook
          'untabify)

;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook
          'whitespace-cleanup)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; paredit on for clojure
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

;; rainbow parens
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; delete trailing whitespace on save
(add-hook 'prog-mode-hook 'delete-trailing-whitespace)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0e219d63550634bc5b0c214aced55eb9528640377daf486e13fb18a32bf39856" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" default)))
 '(package-selected-packages
   (quote
    (go-mode php+-mode dockerfile-mode cider zenburn-theme yaml-mode sass-mode rainbow-delimiters php-mode paredit multiple-cursors markdown-mode magit hy-mode expand-region elixir-mode clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'unicode-fonts)
(require 'persistent-soft) ; To cache the fonts and reduce load time
(unicode-fonts-setup)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq
   message-send-mail-function   'smtpmail-send-it
   smtpmail-smtp-server         "localhost"
   smtpmail-local-domain        "procrustes.net"

   ;; so your plaintext emails wrap nicely in other clients.
   mu4e-compose-format-flowed t

   mu4e-use-fancy-chars t
   mu4e-view-show-images t
   mu4e-view-show-addresses t
   )
