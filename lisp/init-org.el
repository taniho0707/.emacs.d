;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((gnuplot . t)
   (R . nil)
   (emacs-lisp . nil)
   ))

(require 'gnuplot-mode)

;; R
(require 'ess-site)
(require 'ob-R)


;; disable question before execute
(setq org-confirm-babel-evaluate nil)

;; http://futurismo.biz/archives/2907
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)


;; org-present
(require 'org-present)
(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))
     ;; 文字をどれだけ大きくするかを設定する
     (setq org-present-text-scale 5)
     ;; 日本語キーボードの人はC-c C-;に割り当てるとよい
     (define-key org-present-mode-keymap (kbd "C-c C-;") 'org-present-big)))

