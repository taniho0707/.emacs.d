;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


;; Anythingの設定
(require 'anything)
(define-key global-map (kbd "C-;") 'anything)


;; Emacsコマンドを表示できるようにする
(require 'anything-config)
(setq anything-sources
      '(anything-c-source-buffers+
	anything-c-source-colors
	anything-c-source-recentf
	anything-c-source-man-pages
	anything-c-source-emacs-commands
	anything-c-source-emacs-functions
	anything-c-source-files-in-current-dir
	))

;; 履歴を保持する
(require 'recentf)
(setq recentf-max-saved-items 1000)
(recentf-mode 1)

