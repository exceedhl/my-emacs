(add-to-list 'load-path "~/.emacs.d/muse")
(add-to-list 'load-path "~/.emacs.d/muse/contrib")
(add-to-list 'load-path "~/.emacs.d/muse/experimental")
(add-to-list 'load-path "~/.emacs.d")

(require 'muse-mode)     
(require 'muse-colors)
(require 'muse-html)     
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-xml)
(require 'muse-docbook)
(require 'muse-journal)
(require 'muse-project)  
(require 'muse-wiki)
(require 'muse-cite)
;;; Htmlize
(require 'htmlize)
(require 'htmlize-hack)


(muse-derive-style "jekyll-xhtml" "xhtml"
                   :header (concat  
			    "---\n" 
			    "<lisp>(concat \"title: \" (muse-publishing-directive \"title\") \"\\n\"
    (let ((date (muse-publishing-directive \"date\")))
      (when date (concat \"date: \" date \"\\n\")))
    (let ((layout (muse-publishing-directive \"layout\")))
      (when layout (concat \"layout: \" layout \"\\n\")))
    (let ((category (muse-publishing-directive \"category\")))
      (when category (concat \"category: \" category \"\\n\")))
    (let ((tags (muse-publishing-directive \"tags\")))
      (when tags (concat \"tags: \" tags \"\\n\"))))</lisp>" 
			    "---\n")
		   :footer ""
		   :style-sheet "")

(setq muse-project-alist
      '(("Journals" ("~/Desktop/mine/journals" :default "index")
	 (:base "html" :path "~/Desktop/mine/journals/public_html"))
	("ChangeProgram" ("~/Desktop/mine/articles/change_program" :default "index")
	 (:base "html" :path "~/Desktop/mine/articles/change_program/public_html")
	 (:base "latexcjk" :path "~/Desktop/mine/articles/change_program/public_pdf"))
	("Blog" ("~/Desktop/public/posts" :default "index")
	 (:base "jekyll-xhtml" :path "~/Desktop/public/output/posts"))))

(setq muse-latex-pdf-program "/usr/texbin/xelatex")
(setq muse-latexcjk-header
  "\\documentclass[nofonts,10pt]{ctexart}
\\usepackage[dvipdfm, colorlinks=true, pdfstartview=FitH]{hyperref}
\\usepackage[a4paper]{geometry}
\\usepackage[english]{babel}
\\setCJKmainfont[BoldFont={Adobe Heiti Std},ItalicFont={Adobe Kaiti Std}]{SimSun}
\\setmainfont{Adobe Garamond Pro}
\\setsansfont{Helvetica Neue}

\\begin{document}
\\title{<lisp>(muse-publish-escape-specials-in-string
  (muse-publishing-directive \"title\") 'document)</lisp>}
\\author{<lisp>(muse-publishing-directive \"author\")</lisp>}
\\date{<lisp>(muse-publishing-directive \"date\")</lisp>}

\\maketitle

<lisp>(and muse-publish-generate-contents
           (not muse-latex-permit-contents-tag)
           \"\\\\tableofcontents\n\\\\newpage\")</lisp>\n\n")

(setq muse-latexcjk-footer "\\end{document}\n")

(provide 'muse-init)