;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


;; git-gutter
(global-git-gutter-mode t)


;; Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

