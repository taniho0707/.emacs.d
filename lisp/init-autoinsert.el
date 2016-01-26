;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


(require 'autoinsert)
(auto-insert-mode 1)
(setq auto-insert-directory "~/.emacs.d/template")
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . "template.cpp")
               ("\\.hpp$" . "template.hpp")
               ("\\.tex$" . "template.tex")
               ("\\.pl$" . "template.pl")
               ("\\.c$" . "template.c")
               ("\\.h$" . "template.h")
;; sample  ("\\.h$" . ["template.h" my-template])
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



;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-20150415.244/snippets" 
        ))
(yas-global-mode 1)



;; flycheckの設定
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c++-mode-common-hook 'flycheck-mode)

(require 'flycheck)
(flycheck-define-checker c/c++
  "A C/C++ checker using g++."
  :command ("g++" "-Wall" "-Wextra" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " エラー: " (message)
                           line-end)
                    (warning line-start
                           (file-name) ":" line ":" column ":" " 警告: " (message)
                           line-end))
  :modes (c-mode c++-mode))


