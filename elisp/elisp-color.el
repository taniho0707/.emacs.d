;; -*- Emacs-Lisp -*-
;; elisp-color.el

(defface my-face-elisp-macro
  '((t (:foreground "sea green"))) nil)
(defface my-face-elisp-subr
  '((t (:foreground "purple"))) nil)
(defface my-face-elisp-func
  '((t (:foreground "light blue"))) nil)
(defun my-font-lock-elisp-macro (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq (get-text-property
                         0 'face (match-string 1))
                        '(font-lock-comment-face
                          font-lock-warning-face)))
             (condition-case nil
                 (symbol-function
                  (intern-soft
                   (match-string-no-properties 1)))
               (error nil)))
        (my-font-lock-elisp-macro limit))))
(defun my-font-lock-elisp-subr (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq (get-text-property
                         0 'face (match-string 1))
                        '(font-lock-comment-face
                          font-lock-warning-face)))
             (subrp
              (condition-case nil
                  (symbol-function
                   (intern-soft
                    (match-string-no-properties 1)))
                (error nil))))
        (my-font-lock-elisp-subr limit))))
(defun my-font-lock-elisp-func (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq
                   (get-text-property
                    0 'face (match-string 1))
                   '(font-lock-comment-face
                     font-lock-warning-face)))
             (byte-code-function-p
              (condition-case nil
                  (symbol-function
                   (intern-soft
                    (match-string-no-properties 1)))
                (error nil))))
        (my-font-lock-elisp-func limit))))
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-macro 1 'my-face-elisp-macro t)) t)
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-func 1 'my-face-elisp-func t)) t)
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-subr 1 'my-face-elisp-subr t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-macro 1 'my-face-elisp-macro t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-func 1 'my-face-elisp-func t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-subr 1 'my-face-elisp-subr t)) t)

(provide 'elisp-color)
