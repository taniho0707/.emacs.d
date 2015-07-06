;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
(require 'cl)

;;;--------------------------------------------------------------------------
;;; 標準機能の設定
;;;--------------------------------------------------------------------------

;; パッケージマネージャの設定
(require 'package)
; Add package-archives
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
; Initialize
(package-initialize)

;; themeのロード
;; dark-laptopをロード
(load-theme 'dark-laptop t)
(enable-theme 'dark-laptop)

;; スタートアップメッセージ非表示
(setq inhibit-startup-screen t)

;; 日本語環境の設定
(set-language-environment "Japanese")

;; TABの表示幅を8から4に変更
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216))

;; TABではなくスペースを使う
(setq-default indent-tabs-mode nil)

;; c-mode のインデントをスペース4個分のタブにする
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "k&r")
             (setq c-basic-offset 4)
             (setq indent-tabs-mode t)
             (setq tab-width 4)))

;; 改行コード表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; C-kで行全体を削除
(setq kill-whole-line t)

;; バッファー名の問い合わせで大文字小文字の区別をしない
(setq read-buffer-completion-ignore-case t)
;; ファイル名の問い合わせで大文字小文字の区別をしない
(setq read-file-name-completion-ignore-case t)

;; バッファの自動再読み込み
(global-auto-revert-mode 1)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-macimum-output t) ;; for shell-mode

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; バッファ一覧をまともに
(global-set-key "\C-x\C-b" 'bs-show)

;; インライン画像の表示
(setq org-startup-with-inline-images t)

;; 画像ファイルを表示
(auto-image-file-mode t)

;; 最終行に必ず1行挿入する
(setq require-final-newline t)

;; ウインドウ上部に現在の関数名を表示
(which-function-mode 1)

;; 自動でスペルチェックを実行する
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;; 特殊文字の色付け
;; http://masutaka.net/chalow/2011-10-12-1.html
(global-whitespace-mode 1)
(setq whitespace-style '(face tabs tab-mark spaces space-mark newline newline-mark))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
        (newline-mark ?\n [?\u21B5 ?\n] [?$ ?\n])
        ))
(set-face-foreground 'whitespace-tab "#7594FF")
(set-face-background 'whitespace-tab 'nil)
(set-face-foreground 'whitespace-space "#7594FF")
(set-face-background 'whitespace-space 'nil)
(set-face-foreground 'whitespace-newline "#7594FF")
(set-face-background 'whitespace-newline 'nil)

;; 日本語フォントの設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Hiragino Mincho Pro"))

;; メニューバーにファイルのフルパスを表示
;; (setq frame-title0format (format "%%f"))

;; ファイルの拡張子とモードの関連付け
(add-to-list 'auto-mode-alist '("\\.ddl$" . sql-mode))

;; 対応するカッコを表示させる
(show-paren-mode 1)

;;シェルに合わせるためにC-hを後退に割り当てる
;; ※ヘルプは<f1>も使える
(global-set-key (kbd "C-h") 'delete-backward-char)

;; 言語設定
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; 現在行に色を付ける
(global-hl-line-mode 1)

;; リージョンに色を付ける
(transient-mark-mode 1)

;; 行番号、桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;; "C-m"に newline-and-indent を割り当てる(初期値は newline)
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; 大きいファイルを開こうとした時に警告を発生させる
;; デフォルトは10MBなので50MBに拡張する
(setq large-file-warning-threshold (* 50 1024 1024))

;; C-x bでミニバッファにバッファ候補を表示
;; 標準ではC-x C-bでバッファ一覧を出せる
; (iswitchb-mode t)
; (iswitchb-default-keybindings)

;; C-kで行全体を削除
(setq kill-whole-lint t)

;; 先頭が#!から始まる場合，実行権限をつけて保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)


;;;--------------------------------------------------------------------------
;;; 編集モードとテンプレート等々
;;;--------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.p[lm]$" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(require 'autoinsert)
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . ["template.cpp" my-template])
               ("\\.hpp$" . ["template.hpp" my-template])
               ("\\.tex$" . ["template.tex" my-template])
               ("\\.pl$" . ["template.pl" my-template])
               ("\\.c$" . ["template.c" my-template])
               ("\\.h$" . ["template.h" my-template])
               ) auto-insert-alist))

;; ファイルごとの自動生成部
(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%" . (lambda () (format "__INCLUDED_%s_H__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
(add-hook 'find-file-not-found-hooks 'auto-insert)


;;;--------------------------------------------------------------------------
;;; キーコンフィグの設定
;;;--------------------------------------------------------------------------
;; C-x C-l で現在行をtopにする
;; 元々はC-u 0 C-l
(defun line-to-top-of-window ()
  "Move the line point is on to top of window."
  (interactive)
  (recenter 0))
(global-set-key "\C-x\C-l" 'line-to-top-of-window)

;; F5 でコンパイル
(global-set-key [f5] 'compile)
(setq compilation-window-height 10)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;;;--------------------------------------------------------------------------
;;; 標準pluginの設定
;;;--------------------------------------------------------------------------
;; 行番号表示
(require 'linum)
(global-linum-mode 1)

;; cua-mode: 短形編集を強力にする
;; リージョン選択中に C-RET で短形編集に入る。C-gで終了
(require 'cua-mode nil t)
(cua-mode t)
(setq cua-enable-cua-keys nil)



;;;--------------------------------------------------------------------------
;;; 追加pluginの設定
;;;--------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/auto-install")

;; auto-install
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'auto-install)
(setq auto-install-direcroty "~/.emacs.d/elisp/")

;; Elispの予約後に色付け
(require 'elisp-color)

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; auto-complete-latex
(require 'auto-complete-latex)
(setq ac-l-source-user-keywords*
      '("aaa" "bbb" "ccc"))
(add-to-list 'ac-modes 'tex-mode)

;; perl-completion
(require 'perl-completion)
(add-hook 'cperl-mode-hook (lambda ()
                             (require 'perl-completion)
                             (add-to-list 'ac-sources 'ac-source-perl-completion)
                             (perl-completion-mode t)))


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

;; twittering-mode
(require 'twittering-mode nil t)
(setq twittering-auth-method 'oauth)
(setq twittergin-icon-mode t)

;; LaTeXの文書クラスについては以下を参照
;; http://keizai.xrea.jp/latex/tutorial/class.html
;; init.elの設定については以下を参照
;; http://d.hatena.ne.jp/tamura70/20100217/org
;; http://skalldan.wordpress.com/2011/06/10/%E5%9F%B7%E7%AD%86%E7%92%B0%E5%A2%83/
(setq org-export-latex-coding-system 'shift_jis)
(setq org-export-latex-date-format "%Y-%m-%d")
(setq org-export-latex-classes nil)
(add-to-list 'org-export-latex-classes
  '("jsarticle"
    "\\documentclass[a4j]{jsarticle}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
))
(setq org-export-latex-packages-alist
  '(("AUTO" "inputenc"  t)
    ("T1"   "fontenc"   t)
;;     ("deluxe,expert,multi"     "otf"   nil)
;;     ;; (""     "txfonts"   nil)
;; ;;     ;; ...                                     ; 使用するパッケージを適宜追加
    ))

