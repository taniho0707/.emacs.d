;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


(add-to-list 'load-path "~/.emacs.d/yatex")


;; YaTeX関係
;; 拡張子が .tex なら yatex-mode に
(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;; YaTeX が利用する内部コマンドを定義する
(setq tex-command "./build.sh") ;; 自作したコマンドを
(setq dvi2-command "evince") ;; evince で PDF を閲覧
(add-hook 'yatex-mode-hook '(lambda () (setq auto-fill-function nil)))


;; LaTeXの文書クラスについては以下を参照
;; http://keizai.xrea.jp/latex/tutorial/class.html
;; init.elの設定については以下を参照
;; http://d.hatena.ne.jp/tamura70/20100217/org
;; http://skalldan.wordpress.com/2011/06/10/%E5%9F%B7%E7%AD%86%E7%92%B0%E5%A2%83/
(setq org-export-latex-coding-system 'shift_jis)
(setq org-export-latex-date-format "%Y-%m-%d")
(setq org-export-latex-classes nil)
(add-to-list 'org-export-latex-classes
  '("jsarticle"
    "\\documentclass[a4j]{jsarticle}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
))
(setq org-export-latex-packages-alist
  '(("AUTO" "inputenc"  t)
    ("T1"   "fontenc"   t)
;;     ("deluxe,expert,multi"     "otf"   nil)
;;     ;; (""     "txfonts"   nil)
;; ;;     ;; ...                                     ; 使用するパッケージを適宜追加
    ))


;; org->latex
(require 'ox-latex)
;(require 'ox-bibtex)
; tex->pdf
(setq org-latex-pdf-process
      '("uplatex %f"
        "uplatex %f"
        "dvipdfmx %b.dvi"))

; \hypersetup{...} を出力しない
(setq org-latex-with-hyperref nil)

; Header
(add-to-list 'org-latex-classes
             '("thesis"
               "\\documentclass[a4paper,11pt]{ujarticle}
               \\usepackage[margin=3cm]{geometry}
               \\usepackage[dvipdfmx]{graphicx}
               \\usepackage{enumerate}
               \\usepackage{amsmath}
               \\usepackage{here}
               \\usepackage{ascmac}
               \\usepackage{here}
               \\usepackage{txfonts}
               \\usepackage{listings}
               \\renewcommand{\\lstlistingname}{リスト}
               \\lstset{language=c,
                 basicstyle=\\ttfamily\\scriptsize,
                 commentstyle=\\textit,
                 classoffset=1,
                 keywordstyle=\\bfseries,
                 frame=tRBl,
                 framesep=5pt,
                 showstringspaces=false,
                 numbers=left,
                 stepnumber=1,
                 numberstyle=\\tiny,
                 tabsize=2
               }
               \\makeatletter
               \\def\\mojiparline#1{
                   \\newcounter{mpl}
                   \\setcounter{mpl}{#1}
                   \\@tempdima=\\linewidth
                   \\advance\\@tempdima by-\\value{mpl}zw
                   \\addtocounter{mpl}{-1}
                   \\divide\\@tempdima by \\value{mpl}
                   \\advance\\kanjiskip by\\@tempdima
                   \\advance\\parindent by\\@tempdima
               }
               \\makeatother
               \\def\\linesparpage#1{
                   \\baselineskip=\\textheight
                   \\divide\\baselineskip by #1
               }"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



