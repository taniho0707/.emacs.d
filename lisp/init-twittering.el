;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; twittering-mode
(require 'twittering-mode)

; パスワードをホームディレクトリにgpgで保存
(setq twittering-use-master-password t)
(setq twittering-auth-method 'oauth)

; アイコンを表示
(setq twittering-icon-mode t)
(setq twittering-use-ssl t)

; 60秒でタイムラインを更新
(setq twittering-timer-interval 60)

(setq twittering-username "taniho_0707")
(setq twittering-convert-fix-size 32)

; 起動時に読み込むタイムライン
(setq twittering-initial-timeline-spec-string
      '(":mentions"
        "taniho_0707/大学"
        "taniho_0707/HORIKAWAS"))

