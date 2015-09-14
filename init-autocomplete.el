;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

; auto-complete-c-headers
(require 'auto-complete-c-headers)
(add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))


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

