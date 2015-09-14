;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


(setq load-path 
      (append '(
                "~/.emacs.d"
                ) load-path))

;; 分割ファイルのロード
(load "init-main")
(load "init-packages")
(load "init-autoinsert")
(load "init-anything")
(load "init-autocomplete")
(load "init-twittering")
(load "init-git")
(load "init-org")
(load "init-latex")
(load "init-additional")
(load "init-e2wm")

