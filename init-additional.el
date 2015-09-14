;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;--------------------------------------------------------------
;;; 追加pluginの設定
;;;--------------------------------------------------------------

;; Elispの予約後に色付け
(require 'elisp-color)

;; sense-region
;; 短形選択
;(add-to-list 'load-path "~/.emacs.d/elisp/sense-region")
;(require 'sense-region)
;(sense-region-on)

;; graphviz
(add-hook 'graphviz-dot-mode-hook (lambda () (local-set-key [f5] "\C-x\C-s\C-cc\C-m\C-cp")))


;; rainbow-delimiters-mode
(defun my-rainbow-delimiters-mode-turn-on ()
  (rainbow-delimiters-mode t))
(add-hook 'emacs-lisp-mode-hook 'my-rainbow-delimiters-mode-turn-on)

;; rainbow-mode
(defun my-rainbow-mode-turn-on ()
  (rainbow-mode t))
(add-hook 'css-mode-hook 'my-rainbow-mode-turn-on)
(add-hook 'html-mode-hook 'my-rainbow-mode-turn-on)

;; volatile-highlight
;; (require 'volatile-highlight)
;; (volatile-highlight 1 10)

;; anzu
(require 'anzu)
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; quickrun
(require 'quickrun)
;; 結果の出力バッファと元のバッファを行き来したいので
;; ':stick t'の設定をする
;; (push '("*quickrun*") popwin:special-display-config)
;; よく使う(と思う)ので F7 キーを割り当てる
(global-set-key (kbd "<f7>") 'quickrun)

;; perl-completion
;; (require 'perl-completion)

;; emmet-mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook
          (lambda ()
            (setq emmet-indentation 4)))
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap
     (kbd "C-j") nil))
 (define-key emmet-mode-keymap
   (kbd "H-i") 'emmet-expand-line)


;; cat-mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/cat-mode"))
(require 'cat-mode)

