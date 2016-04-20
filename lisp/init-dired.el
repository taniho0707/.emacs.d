;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://keens.github.io/blog/2013/10/04/emacs-dired/

(ffap-bindings)

;; "r" to enable editing in buffer, then "C-x C-s" to finish.
(add-hook 'dired-load-hook (lambda ()
                             (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)))

;; copy assist
(setq dired-dwim-target t)


;; http://fukuyama.co/autojump
(require 'recentf)
(recentf-mode t)

(defun open-dired-from-recentf (keyword)
  (interactive "spart of name(dir): ")
  (with-temp-buffer
    (insert (format "%s" recentf-list))
    (delete-backward-char 1)
    (goto-char (point-min))
    (delete-char 1)
    (while (re-search-forward "\\s-\/" nil t)
      (replace-match "\n/"))
    (goto-char (point-min))
    (search-forward keyword)
    (dired (file-name-directory (thing-at-point 'line)))
    ))
(global-set-key (kbd "C-x C-d") 'open-dired-from-recentf)
