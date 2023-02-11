;; -*- mode: elisp -*-

;; Load custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

;; Remove toolbars
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Disable bell sound enable visual
(setq visible-bell 1)

;; Gather backup files in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 10   ; how many of the newest versions to keep
  kept-old-versions 3    ; and how many of the old
  )
