;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


(setq load-path 
      (append '(
                "/home/nonoho/.emacs.d/lisp"
                ) load-path))

;; 分割ファイルのロード
(load "init-main.el")
(load "init-packages")
(load "init-dired")
(load "init-autoinsert")
;(load "init-anything")
(load "init-helm")
(load "init-autocomplete")
(load "init-twittering")
(load "init-git")
(load "init-org")
(load "init-latex")
(load "init-additional")
(load "init-e2wm")

