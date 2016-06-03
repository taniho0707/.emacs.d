;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;--------------------------------------------------------------
;;; 追加pluginの設定
;;;--------------------------------------------------------------

;; Elispの予約後に色付け
(require 'elisp-color)

;; sync-recentf with multiple emacses
(require 'sync-recentf)
(setq recentf-auto-cleanup 60)
(recentf-mode 1)

;; sense-region
;; 短形選択
;(add-to-list 'load-path "/home/nonoho/.emacs.d/elisp/sense-region")
;(require 'sense-region)
;(sense-region-on)

;; graphviz
(add-hook 'graphviz-dot-mode-hook (lambda () (local-set-key [f5] "\C-x\C-s\C-cc\C-m\C-cp")))

;; matlab-mode
(add-hook 'matlab-mode-hook
  (lambda ()
    (local-set-key (kbd "C-h") 'backward-delete-char)))

;; recentf
;; http://qiita.com/catatsuy/items/f9fad90fa1352a4d3161
;; 自動保存
(when (require 'recentf-ext nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))
;; 起動画面削除
(setq inhibit-startup-message t)
;; 起動画面で recentf を開く
(add-hook 'after-init-hook (lambda()
    (recentf-open-files)
    ))

;; open-junk-file
;; C-x jでジャンクファイルを作成・開く
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y-%m-%d-%H%M%S.")
(global-set-key (kbd "C-x j") 'open-junk-file)


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

;; Haskell mode
;; http://futurismo.biz/archives/2662
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
 
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)


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
(add-to-list 'load-path (expand-file-name "/home/nonoho/.emacs.d/elisp/cat-mode"))
(require 'cat-mode)


;; mozc-emacs
(add-to-list 'load-path "/usr/share/emacs/24.3/site-lisp/emacs-mozc")
(require 'mozc)
(setq default-input-method "japanese-mozc")
;; (global-set-key (kbd "C-\\") 'mozc-mode)
(global-set-key [muhenkan] 'mozc-mode)


;; Fix better enum class in C++11
(defun inside-class-enum-p (pos)
  "Checks if POS is within the braces of a C++ \"enum class\"."
  (ignore-errors
    (save-excursion
      (goto-char pos)
      (up-list -1)
      (backward-sexp 1)
      (looking-back "enum[ \t]+class[ \t]+[^}]+"))))

(defun align-enum-class (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    (c-lineup-topmost-intro-cont langelem)))

(defun align-enum-class-closing-brace (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      '-
    '+))

(defun fix-enum-class ()
  "Setup `c++-mode' to better handle \"class enum\"."
  (add-to-list 'c-offsets-alist '(topmost-intro-cont . align-enum-class))
  (add-to-list 'c-offsets-alist
               '(statement-cont . align-enum-class-closing-brace)))

;; emoji-fontset
(emoji-fontset-enable "Symbola")

; (add-hook 'c++-mode-hook 'fix-enum-class)
