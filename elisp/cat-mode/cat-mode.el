;;; cat-mode.el --- Minor mode for FuelPHP project

;; Copyright (C) 2014 by Mugijiru

;; Author: Mugijiru <mugijiru.dev@gmail.com>
;; URL: https://github.com/mugijiru/cat-mode
;; Version: 0.01

;;; The MIT License:

;; http://en.wikipedia.org/wiki/MIT_License
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Commentary:

;;; Code:


(defgroup cat nil
  "cat-mode customize"
  :prefix "cat-"
  :group 'cat)

(defvar cat-mode-buf-name "*cat-mode*")
(defvar cat-api-url "http://thecatapi.com/api/images/get?size=med&type=png")

(defun cat-mode ()
  "猫画像を表示するモード。
thecatapi利用"
  (interactive)
  (let ((cat-mode-buf (get-buffer-create cat-mode-buf-name)))
    (switch-to-buffer cat-mode-buf)
    (setq major-mode 'cat-mode)
    (setq mode-name "cat-mode")
    (setq cat-mode-map (make-keymap))
    (define-key cat-mode-map (kbd "q") 'cat-mode-quit)
    (define-key cat-mode-map (kbd "RET") 'cat-load-image)
    (use-local-map cat-mode-map)
    (cat-load-image)))

(defun cat-load-image ()
  "猫画像を読み込んで表示する関数"
  (interactive)
  (let* ((cat-tmp-file-name "/tmp/cat.png")
         (command (concat "wget -q '" cat-api-url "' -O " cat-tmp-file-name)))
    (setq buffer-read-only nil)
    (clear-image-cache)
    (shell-command command)
    (delete-other-windows)
    (erase-buffer)
    (insert-image (create-image cat-tmp-file-name))
    (setq buffer-read-only t)))

(defun cat-mode-quit ()
  "終了コマンド"
  (interactive)
  ;;(message "")
  (quit-window cat-mode-buf-name))

(provide 'cat-mode)
