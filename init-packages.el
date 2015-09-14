;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


;; パッケージマネージャの設定
(require 'package)
; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
; Initialize
(package-initialize)


(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/auto-install")

;; auto-install
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'auto-install)
(setq auto-install-direcroty "~/.emacs.d/elisp/")

