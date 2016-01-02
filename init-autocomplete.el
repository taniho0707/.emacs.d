;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; company-mode
(require 'company)
(global-company-mode) ; 全バッファで有効にする 
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;; irony for company-mode
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options) ; コンパイルオプションの取得用
(add-to-list 'company-backends 'company-irony) ; backend追加


;; yasnippet additional settings
(yas-global-mode)

;; ;; auto-complete
;; (require 'auto-complete)
;; (global-auto-complete-mode t)

;; ; auto-complete-c-headers
;; (require 'auto-complete-c-headers)
;; (add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
;; (add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))


;; ;; auto-complete-latex
;; (require 'auto-complete-latex)
;; (setq ac-l-source-user-keywords*
;;       '("aaa" "bbb" "ccc"))
;; (add-to-list 'ac-modes 'tex-mode)

;; ;; perl-completion
;; (require 'perl-completion)
;; (add-hook 'cperl-mode-hook (lambda ()
;;                              (require 'perl-completion)
;;                              (add-to-list 'ac-sources 'ac-source-perl-completion)
;;                              (perl-completion-mode t)))

