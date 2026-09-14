;; -*- lexical-binding: t; -*-
;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
;(eval-and-compile
;  (when (or load-file-name byte-compile-current-file)
;    (setq user-emacs-directory
;          (expand-file-name
;           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))
  :bind (("M-ESC ESC" . c/redraw-frame)
	 ("C-z" . undo)
	 ("C-h" . delete-backward-char)
     ("C-c l" . display-line-numbers-mode)
     ("C-c /" . comment-or-uncomment-region)
     ("C-s" . isearch-forward))
  :custom '((user-full-name . "taniho_0707")
            (user-mail-address . "taniho_0707@yahoo.co.jp")
            (user-login-name . "taniho_0707")
            (create-lockfiles . nil)
            (backup-inhibited . t)
            (tab-width . 4)
            (debug-on-error . t)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)
            (mouse-wheel-scroll-amount . '(3 ((control) . 15)))
            (mouse-wheel-follow-mouse . 't)
            (mouse-wheel-progressive-speed . nil)
            (scroll-step . 1)
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            (use-dialog-box . nil)
            (use-file-dialog . nil)
            (menu-bar-mode . t)
            (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (indent-tabs-mode . nil)
            (truncate-lines . t)
            (truncate-partial-width-windows . t)
            (line-number-mode . 1)
            (column-number-mode . 1)
            (which-function-mode . 1)
            (default-directory . "~/")
            (command-line-default-directory . "~/")
            (tab-always-indent . 'complete)
            (large-file-warning-threshold . 100000000)
            (delete-by-moving-to-trash . t)
            (show-trailing-whitespace . t)
            (inhibit-startup-screen . t))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?))

;; dired
(leaf dired
  :bind ((:dired-mode-map
          ("u" . dired-up-directory)))
  :custom '((dired-dwim-target . t)
            (dired-recursive-copies . 'always)
            (dired-isearch-filenames . t)))
;  :config
;  (add-to-list 'dired-compress-file-suffixes
;               '("\\.zip\\'" ".zip" "unzip")))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :global-minor-mode global-auto-revert-mode)

(leaf delsel
  :doc "delete selection if you insert"
  :global-minor-mode delete-selection-mode)

(leaf paren
  :doc "highlight matching paren"
  :global-minor-mode show-paren-mode)

(leaf simple
  :doc "basic editing commands for Emacs"
  :custom ((kill-read-only-ok . t)
           (kill-whole-line . t)
           (eval-expression-print-length . nil)
           (eval-expression-print-level . nil)))

(leaf files
  :doc "file input and output commands for Emacs"
  :global-minor-mode auto-save-visited-mode
  :custom `((auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)
            (auto-save-visited-interval . 1)))

(leaf startup
  :doc "process Emacs shell arguments"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))

(leaf savehist
  :doc "Save minibuffer history"
  :custom `((savehist-file . ,(locate-user-emacs-file "savehist")))
  :global-minor-mode t)

(leaf flymake
  :doc "A universal on-the-fly syntax checker"
  :bind ((prog-mode-map
          ("M-n" . flymake-goto-next-error)
          ("M-p" . flymake-goto-prev-error))))

(leaf which-key
  :doc "Display available keybindings in popup"
  :ensure t
  :global-minor-mode t)

(when (memq system-type '(gnu/linux darwin))
    (leaf exec-path-from-shell
      :doc "Get environment variables such as $PATH from the shell"
      :ensure t
      :defun (exec-path-from-shell-initialize)
      :custom ((exec-path-from-shell-check-startup-files)
               (exec-path-from-shell-variables . '("PATH" "GOPATH" "JAVA_HOME")))
      :config
      (exec-path-from-shell-initialize)))

(leaf vertico
  :doc "VERTical Interactive COmpeletion"
  :ensure t
  :global-minor-mode t)

(leaf marginalia
  :doc "Enrich existing commands with completion annotations"
  :ensure t
  :global-minor-mode t)

(leaf consult
  :doc "Consulting completing-read"
  :ensure t
  :hook (completion-list-mode-hook . consult-preview-at-point-mode)
  :defun consult-line
  :preface
  (defun c/consult-line (&optional at-point)
    "Consult-line uses things-at-point if set C-u prefix."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line)))
  :custom ((xref-show-xrefs-function . #'consult-xref)
           (xref-show-definitions-function . #'consult-xref)
           (consult-line-start-from-top . t))
  :bind (;; C-c bindings (mode-specific-map)
         ([remap switch-to-buffer] . consult-buffer) ; C-x b
         ([remap project-switch-to-buffer] . consult-project-buffer) ; C-x p b

         ;; M-g bindings (goto-map)
         ([remap goto-line] . consult-goto-line)    ; M-g g
         ([remap imenu] . consult-imenu)            ; M-g i
         ("M-g f" . consult-flymake)

         ;; C-M-s bindings
         ("C-s" . c/consult-line)       ; isearch-forward
         ("C-M-s" . nil)                ; isearch-forward-regexp
         ("C-M-s s" . isearch-forward)
         ("C-M-s C-s" . isearch-forward-regexp)
         ("C-M-s r" . consult-ripgrep)

         (minibuffer-local-map
          :package emacs
          ("C-r" . consult-history))))

(leaf affe
  :doc "Asynchronous Fuzzy Finder for Emacs"
  :ensure t
  :custom ((affe-highlight-function . 'orderless-highlight-matches)
           (affe-regexp-function . 'orderless-pattern-compiler))
  :bind (("C-M-s r" . affe-grep)
         ("C-M-s f" . affe-find)))

(leaf orderless
  :doc "Completion style for matching regexps in any order"
  :ensure t
  :custom ((completion-styles . '(orderless))
           (completion-category-defaults . nil)
           (completion-category-overrides . '((file (styles partial-completion))))))

(leaf embark-consult
  :doc "Consult integration for Embark"
  :ensure t
  :bind ((minibuffer-mode-map
          :package emacs
          ("M-." . embark-dwim)
          ("C-." . embark-act))))

(leaf corfu
  :doc "COmpletion in Region FUnction"
  :ensure t
  :global-minor-mode global-corfu-mode corfu-popupinfo-mode
  :custom ((corfu-auto . t)
           (corfu-auto-delay . 0)
           (corfu-auto-prefix . 1)
           (corfu-popupinfo-delay . nil)) ; manual
  :bind ((corfu-map
          ("C-s" . corfu-insert-separator))))

(leaf cape
  :doc "Completion At Point Extensions"
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(leaf which-function
  :custom '((which-function-mode . t)))

(leaf time-stamp
  :hook (before-save-hook . time-stamp)
  :custom '((time-stamp-active . t)
            (time-stamp-start . "last updated: ")
            (time-stamp-format . "%Y/%02m/%02d")
            (time-stamp-end . " \n$")))

(leaf hideshow
  :straight nil
  :hook ((prog-mode-hook . hs-minor-mode))
  :custom
  ((hs-show-indicators      . t)     ; 折りたたみ位置に目印を出す
   (hs-display-lines-hidden . t))    ; 何行隠れているか表示する
  :bind ((:hs-minor-mode-map
          ("<backtab>" . hs-cycle))))

(leaf recentf
  :doc "recent file history"
  :ensure nil
  :config
  (setopt recentf-max-asved-items 10000)
  (recentf-mode))

(leaf subword
  :doc "camelCase や snake_case のような複合語をサブワード単位で移動出来るようにする"
  :ensure nil
  :init
  (global-subword-mode))

(leaf tab-bar
  :ensure nil
  :init
  (tab-bar-mode)
  (tab-bar-history-mode))

(leaf repeat
  :doc "例えば C-x o を実行した後、oキー入力のみでコマンドを繰り返す"
  :ensure nil
  :config
  (repeat-mode))

(leaf ediff
  :doc "Emacs 標準の diff ツール"
  :ensure nil
  :custom '((ediff-split-window-function . 'split-window-horizontally)))

(leaf org
  :init
  (setopt org-return-follows-link t))

(leaf org-indent
  :ensure nil
  :hook (org-mode . org-indent-mode))

(leaf magit
  :doc "git client for emacs"
  :bind ("M-g" . magit-status)
  :config
  (set-face-background 'magit-section-highlight "#303030"))

;; ■行削除
(defun my-kill-line ()
  "行頭なら改行を含めて行全体、それ以外なら改行を残して削除する。"
  (interactive)
  (if (= (point) (line-beginning-position))
      (kill-whole-line)
    (kill-line)))

(global-set-key (kbd "C-k") #'my-kill-line)

;; ■補完
(setq competion-ignore-case t) ;; 補完時に大文字小文字を区別しない

;; ■Theme
(use-package vscode-dark-plus-theme
  :ensure t
  :config
  (load-theme 'vscode-dark-plus t))
(setq vscode-dark-plus-render-line-highlight 'line)

;; ■Fonts
(set-face-attribute 'default nil
                    :family "HackGen Console NF"
                    :height 113
                    :width 'normal
                    :weight 'regular
                    :slant 'normal
                    :foundry "outline")

;; ■起動時最大化
(add-hook 'after-init-hook (lambda()
                             (set-frame-parameter nil 'fullscreen 'maximized)))

;; plists and Eglot booster settings
;; https://github.com/blahgeek/emacs-lsp-booster
(setenv "LSP_USE_PLISTS" "true")
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let* ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

(provide 'init)
