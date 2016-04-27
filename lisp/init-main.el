;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; CommonLispの有効化
(require 'cl)
;; .confファイルなどに色を付ける
(require 'generic-x)

;;;--------------------------------------------------------------
;;; 標準機能の設定
;;;--------------------------------------------------------------

;; Emaceclient
(require 'server)
(unless (server-running-p)
  (server-start))

;; themeのロード
;; dark-laptopをロード
(load-theme 'dark-laptop t)
(enable-theme 'dark-laptop)

;; Disable beep tone
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; スタートアップメッセージ非表示
(setq inhibit-startup-screen t)

;; ツールバー非表示
(tool-bar-mode -1)

;; 日本語環境の設定
;(set-language-environment "Japanese")
;;文字コード設定
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8)
;;dired文字コードの設定
(setq dired-default-file-coding-system 'utf-8-unix)

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

;; C-aでインデント文字を飛ばした行頭へ
(global-set-key "\C-a" 'beggining-of-indented-line)
(defun beggining-of-indented-line (current-point)
  (interactive "d")
  (if (string-match
       "^[ \t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

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

;; C言語自動インデントを行う
;(add-hook 'c-mode-common-hook
;          '(lambda ()
;             (c-toggle-auto-hungry-state 1)
;             (define-key c-mode-base-map "\C-m" 'newline-and-indent)))

;; 一度に空白を削除する
(setq c-hungry-delete-key t)

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

;; コードの折りたたみ
(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

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
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; 現在行に色を付ける
(global-hl-line-mode 1)

;; リージョンに色を付ける
(transient-mark-mode 1)

;; 行番号、桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;; "C-m"に newline-and-indent を割り当てる(初期値は newline)
;(define-key global-map (kbd "C-m") 'newline-and-indent)
(define-key global-map (kbd "C-j") 'newline-and-indent)

;; 大きいファイルを開こうとした時に警告を発生させる
;; デフォルトは10MBなので50MBに拡張する
(setq large-file-warning-threshold (* 50 1024 1024))

;; C-x fで最近開いたファイルからファイルを開く
(global-set-key "\C-xf" 'recentf-open-files)

;; C-x bでミニバッファにバッファ候補を表示
;; 標準ではC-x C-bでバッファ一覧を出せる
; (iswitchb-mode t)
; (iswitchb-default-keybindings)

;; C-kで行全体を削除
(setq kill-whole-lint t)

;; 先頭が#!から始まる場合，実行権限をつけて保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; cua-mode
;; http://tech.kayac.com/archive/emacs-rectangle.html
;; C-<Enter> Enterで短形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)


;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))
;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))


;;;--------------------------------------------------------------------------
;;; 編集モードとテンプレート等々
;;;--------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.p[lm]$" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))



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

;; WindMove
;; M-<Up>, M-<Down>, M-<Left>, M-<Right>でWindow移動
(windmove-default-keybindings 'meta)


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

;; eshellモードでのエンコードを指定
(setenv "LANG" "ja_JP.UTF-8")

;; SSH経由でファイル操作を可能とする
;; C-x C-f /ssh:user@hostname#port:.emacs.d/init.el
(require 'tramp)
(setq tramp-default-method "ssh")


;; org-mode settings
(require 'ox-latex)
;(require 'ox-bibtex)
;;; LaTeX 形式のファイル PDF に変換するためのコマンド
(setq org-latex-pdf-process
      '("uplatex %f"
        "uplatex %f"
;        "bibtex %b"
;        "platex %f"
;        "platex %f"
        "dvipdfmx %b.dvi"))
;;; \hypersetup{...} を出力しない
(setq org-latex-with-hyperref nil)



;; 縦横三分割
; http://d.hatena.ne.jp/yascentur/20110621/1308585547
; C-x @で縦3分割，C-x #で横3分割
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-vertically-n 3)))
(global-set-key "\C-x#" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))

