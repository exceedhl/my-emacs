(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote xetex))
 '(TeX-shell "/bin/bash")
 '(TeX-view-program-list nil)
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xpdf") (output-html "xdg-open"))))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-frame-alist (quote ((menu-bar-lines . 1))))
 '(initial-scratch-message "")
 '(large-file-warning-threshold nil)
 '(org-agenda-files (quote ("~/Desktop/mine/notes/reading-list.txt" "~/Desktop/mine/articles/todo.org" "~/Desktop/mine/notes/ideas.org" "~/Desktop/mine/notes/todo.org")))
 '(org-agenda-include-diary t)
 '(org-log-into-drawer t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :background "#242424" :foreground "#E6E1DC" :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "apple" :family "Consolas"))))
 '(dired-directory ((t (:inherit font-lock-function-name-face :foreground "Green")))))

;;; Emacs general behavior setup
(setq backup-inhibited t)
(tool-bar-mode -1)
(setq user-full-name "Huang Liang")
(setq user-mail-address "lhuang@thoughtworks.com")
(setq tramp-default-user "lhuang" tramp-default-host "shell01.kp.realestate.com.au")
(setenv "PATH"
	(concat (getenv "PATH") ":" "/usr/local/bin" ":" "/usr/texbin" ":" "/opt/local/bin"))

;; nice scrolling
(set-scroll-bar-mode nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed t)
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position t)

;; suppress bell sound
(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;;Allow you to type just "y" instead of "yes" when you exit
(fset 'yes-or-no-p 'y-or-n-p) 
;;set auto fill mode
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;; Common Lisp with Slime
(set-language-environment "utf-8")

;;; Set Aspell
(setq-default ispell-program-name "/opt/local/bin/aspell")


(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/elpa")

(require 'package)
(defvar package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook 
	    '(lambda ()
	         ;;; setup rsense
	       (setq rsense-home "/usr/local")
	       (add-to-list 'load-path (concat rsense-home "/etc"))
	       (require 'rsense)
	       (setq ruby-deep-arglist t)
	       (setq ruby-deep-indent-paren nil)
	       (setq c-tab-always-indent nil)
	       (require 'inf-ruby)
	       (require 'ruby-compilation)
	       (define-key ruby-mode-map (kbd "C-.") 'ac-complete-rsense)
	       (add-to-list 'ac-sources 'ac-source-rsense-method)
	       (add-to-list 'ac-sources 'ac-source-rsense-constant)
	       (define-key ruby-mode-map (kbd "C-c C-e") 'run-rails-test-or-ruby-buffer)
	       (define-key ruby-mode-map (kbd "M-r") 'run-rails-test-or-ruby-buffer)
	       (define-key ruby-mode-map (kbd "M-n") 'ruby-end-of-block)
	       (define-key ruby-mode-map (kbd "M-p") 'ruby-beginning-of-block)
	       (define-key ruby-mode-map (kbd "s-n") 'ruby-forward-sexp)
	       (define-key ruby-mode-map (kbd "s-p") 'ruby-backward-sexp))))

(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode)))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
			      (setq css-indent-level 2)
			      (setq css-indent-offset 2))))

(defun is-rails-project ()
  (when (textmate-project-root)
    (file-exists-p (expand-file-name "config/environment.rb" (textmate-project-root)))))

(defun run-rails-test-or-ruby-buffer ()
  (interactive)
  (if (is-rails-project)
      (let* ((path (buffer-file-name))
	     (filename (file-name-nondirectory path))
	     (test-path (expand-file-name "test" (textmate-project-root)))
	     (command (list ruby-compilation-executable "-I" test-path path)))
	(pop-to-buffer (ruby-compilation-do filename command)))
    (ruby-compilation-this-buffer)))

(defun auctex-hook ()
  (setq TeX-engine 'xetex)
  (TeX-global-PDF-mode t) ; PDF mode enable, not plain
  (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
  (setq TeX-auto-save t)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2010/bin/universal-darwin:/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/texlive/2010/bin/universal-darwin"))))

(defun smex-hook ()
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

(defun slime-hook ()
;;; Note that if you save a heap image, the character
;;; encoding specified on the command line will be preserved,
;;; and you won't have to specify the -K utf-8 any more.
  (setq inferior-lisp-program "/opt/local/bin/sbcl -K utf-8")
  (setq slime-net-coding-system 'utf-8-unix)
  (add-hook 'lisp-mode-hook 'slime-mode)
  (require 'slime)
  (load "slime-indentation.el")
  (slime-setup '(slime-indentation slime-repl))
  (define-key slime-mode-map (kbd "C-c C-b") 'slime-eval-buffer)
  (define-key slime-mode-map (kbd "C-c C-c") 'slime-eval-defun))

(defun ac-hook ()
  (ac-config-default))

(defun paredit-hook ()
  (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
  (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
  (define-key paredit-mode-map (kbd ")") 'paredit-close-parenthesis)
  (define-key paredit-mode-map (kbd "M-)") 'paredit-close-parenthesis-and-newline))  

(defun clojure-hook ()
  (require 'clojure-mode)
  (define-key slime-mode-map (kbd "C-c C-b") 'slime-eval-buffer)
  (define-key slime-mode-map (kbd "C-c C-c") 'slime-eval-defun)
  (define-clojure-indent
    (describe 'defun)
    (testing 'defun)
    (given 'defun)
    (using 'defun)
    (with 'defun)
    (context 'defun)
    (it 'defun)
    (do-it 'defun)
    (should 'defun)
    (should-not 'defun)
    (should= 'defun)
    (should-not= 'defun)
    (should-fail 'defun)
    (should-throw 'defun)
    (should-not-throw 'defun)))

(defun mmm-mode-hook ()
  (setq mmm-global-mode 'maybe)
  (setq mmm-submode-decoration-level 0)
  (mmm-add-group
   'fancy-rhtml
   '((html-css
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style"
      :back "</style>")
     (html-javascript
      :submode javascript-mode
      :face mmm-code-submode-face
      :front "<script"
      :back "</script>")))
  ;; What features should be turned on in this html-mode?
  (add-to-list 'mmm-mode-ext-classes-alist '(rhtml-mode nil html-css))
  (add-to-list 'mmm-mode-ext-classes-alist '(rhtml-mode nil html-javascript)))

(defun multi-web-mode-hook ()
  (setq mweb-default-major-mode 'rhtml-mode)
  (setq mweb-tags '((js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("rhtml" "htm" "html" "erb" "rjs"))
  (multi-web-global-mode 1))

(defun yasnippet-hook ()
  (require 'yasnippet)
  (setq yas/snippet-dirs '("~/.emacs.d/el-get/yasnippet/snippets"))
  (yas/global-mode 1))

(defun cucumber-mode-hook () 
  (setq feature-default-language "en")
  (setq feature-default-i18n-file "~/.emacs.d/el-get/cucumber/i18n.yml")
  ;; load bundle snippets
  (yas/load-directory "~/.emacs.d/el-get/cucumber/snippets/feature-mode/")
  (load "feature-mode")
  (add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode)))

(defun coffee-mode-hook ()
  (add-hook 'coffee-mode-hook
	    '(lambda() (set (make-local-variable 'tab-width) 2)))
  (setq coffee-js-mode 'javascript-mode)
  (define-key coffee-mode-map (kbd "C-c C-c") 'coffee-compile-buffer))

(defun mark-multiple-hook ()
  (require 'inline-string-rectangle)
  (global-set-key (kbd "C-x r t") 'inline-string-rectangle)
  (require 'mark-more-like-this)
  (global-set-key (kbd "C-<") 'mark-previous-like-this)
  (global-set-key (kbd "C->") 'mark-next-like-this)
  (global-set-key (kbd "C-*") 'mark-all-like-this)
  (require 'rename-sgml-tag)
  (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag))

(defun ack-hook ()
  (autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
  (autoload 'ack-and-a-half "ack-and-a-half" nil t)
  (autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
  (autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
  ;; Create shorter aliases
  (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same))

(defun ess-hook ()
  (add-to-list 'ac-sources 'ac-source-R)
  (setq ess-use-auto-complete t))

(defun workgroups-hook ()
  (require 'workgroups)
  (setq wg-prefix-key (kbd "C-c w"))
  (workgroups-mode 1)
  (setq wg-morph-on nil)
  (wg-load "~/.emacs.workgroups"))

(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '((:name color-theme-merbivore
	       :type git
	       :url "git://github.com/exceedhl/color-theme-merbivore.git"
	       :load "color-theme-merbivore.el")
	(:name ruby-mode 
	       :type elpa
	       :load "ruby-mode.el"
	       :after (lambda () (ruby-mode-hook)))
	(:name inf-ruby  :type elpa)
	(:name ruby-compilation :type elpa)
	(:name css-mode 
	       :type elpa 
	       :after (lambda () (css-mode-hook)))
	(:name textmate
	       :type git
	       :url "git://github.com/defunkt/textmate.el"
	       :load "textmate.el")
	(:name rhtml
	       :type git
	       :url "https://github.com/crazycode/rhtml.git"
	       :features rhtml-mode
	       :after (lambda () (rhtml-mode-hook)))
	(:name yaml-mode 
	       :type git
	       :url "http://github.com/yoshiki/yaml-mode.git"
	       :features yaml-mode
	       :after (lambda () (yaml-mode-hook)))
	;; (:name mmm-mode
	;; 	 :features mmm-mode
	;; 	 :after (lambda () (mmm-mode-hook)))
	(:name multi-web-mode
	       :type git
	       :url "https://github.com/fgallina/multi-web-mode.git"
	       :features multi-web-mode
	       :after (lambda () (multi-web-mode-hook)))
	(:name smex 
	       :load "smex.el"
	       :after (lambda () (smex-hook)))
	(:name workgroups
	       :url "https://github.com/tlh/workgroups.el.git"
	       :load "workgroups.el"
	       :after (lambda () (workgroups-hook)))
	(:name slime
	       :after (lambda () (slime-hook)))
	(:name ac-slime
	       :type git
	       :url "https://github.com/purcell/ac-slime.git"
	       :load "ac-slime.el"
	       :after (lambda () (add-hook 'slime-mode-hook 'set-up-slime-ac)
			(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)))
	(:name paredit 
	       :type elpa
	       :load "paredit.el"
	       :after (lambda () (paredit-hook)))
	(:name yasnippet 
	       :type git
	       :url "https://github.com/capitaomorte/yasnippet.git"
	       :after (lambda () (yasnippet-hook)))
	(:name cucumber
	       :type git
	       :url "https://github.com/michaelklishin/cucumber.el.git"
	       :load "feature-mode.el"
	       :after (lambda () (cucumber-mode-hook)))
	(:name coffee-mode
	       :after (lambda () (coffee-mode-hook)))
	(:name fastnav
	       :type git
	       :url "https://github.com/gleber/fastnav.el.git")
	(:name mark-multiple
	       :type git
	       :url "https://github.com/magnars/mark-multiple.el.git"
	       :after (lambda () (mark-multiple-hook)))
	(:name expand-region
	       :type git
	       :url "https://github.com/magnars/expand-region.el.git")
	(:name auto-complete
	       :after (lambda () (ac-hook)))
	(:name clojure-mode
	       :after (lambda () (clojure-hook)))
	(:name ack-and-a-half
	       :type git
	       :url "https://github.com/jhelwig/ack-and-a-half.git"
	       :after (lambda () (ack-hook)))
	(:name ess
	       :after (lambda () (ess-hook)))
	;; (:name auctex
	;;        :build `("./autogen.sh" "rm -rf /tmp/auctex" "mkdir /tmp/auctex" ,(concat "./configure --with-texmf-dir=/tmp/auctex --with-lispdir=`pwd` --with-emacs=" el-get-emacs) "make")
	;;        :after (lambda () (auctex-hook)))
	(:name anything
	       :load "anything-config.el")))
(setq my-packages (append '(ido-hacks magit color-theme nxhtml coffee-mode ace-jump-mode) (mapcar 'el-get-source-name el-get-sources))) 
(el-get 'sync my-packages)

;;; Muse
(require 'muse-init)

;;; Buffer switch
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(require 'ebs)
(ebs-initialize)
(global-set-key [(control tab)] 'ebs-switch-buffer)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;; set recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
(global-set-key (kbd "s-P") 'recent-jump-backward)
(global-set-key (kbd "s-N") 'recent-jump-forward)
(require 'recent-jump)
(recent-jump-mode 1)

;;; number-window mode
(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)
(window-number-meta-mode 1)
(window-number-define-keys window-number-meta-mode-map "s-")

;;; set mic-paren
(require 'mic-paren)
(paren-activate) 

;;; speedbar
;; (require 'sr-speedbar)

;;; peepopen
(require 'peepopen)
(textmate-mode)
(define-key *textmate-mode-map* (kbd "s-t") nil)
(setq ns-pop-up-frames nil)

;;; uniquify filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;;; set pending delete mode
(pending-delete-mode t)

;; show-paren-mode: subtle highlighting of matching parens (global-mode)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis)

;;; Global key bindings
(global-set-key (kbd "s-t") 'ido-switch-buffer)
(global-set-key (kbd "s-o") 'delete-other-windows)
(global-set-key (kbd "s-O") 'delete-window)
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "s-d") 'kill-whole-line)
(global-set-key (kbd "s-p") 'backward-sexp)
(global-set-key (kbd "s-n") 'forward-sexp)
(global-set-key (kbd "M-p") 'backward-list)
(global-set-key (kbd "M-n") 'forward-list)
(global-set-key (kbd "M-u") 'backward-up-list)
(global-set-key (kbd "M-U") 'down-list)
(global-set-key (kbd "M-C-n") 'make-frame)
(global-set-key (kbd "<M-down>") 'scroll-up-command)
(global-set-key (kbd "<M-up>") 'scroll-down-command)
(global-set-key (kbd "C-c d e") 'kill-sexp)
(global-set-key (kbd "C-c d a") 'backward-kill-sexp)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "s-/") 'comment-region)
(global-set-key (kbd "s-?") 'uncomment-region)
(global-set-key (kbd "C-c f f") 'ack)
(global-set-key (kbd "C-c f o") 'occur)
(global-set-key (kbd "M-\\") 'just-one-space)
(global-set-key (kbd "M-|") 'delete-horizontal-space)
(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
(global-set-key "\M-m" 'fastnav-mark-to-char-forward)
(global-set-key "\M-M" 'fastnav-mark-to-char-backward)
(global-set-key (kbd "s-j") 'ace-jump-mode)
;; (global-set-key "\M-j" 'fastnav-jump-to-char-forward)
(global-set-key "\M-J" 'fastnav-jump-to-char-backward)
(global-set-key (kbd "s-r") 'repeat)
(global-set-key (kbd "s-w") 'er/expand-region)
(global-set-key (kbd "<M-f4>") 'delete-frame)
;; (global-set-key (kbd "s-w") ')
;; (global-set-key (kbd "s-q") 'quit-window)

;;; Org mode key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; open previous and next line
;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(global-set-key (kbd "<s-return>")   'open-next-line)
(global-set-key (kbd "<C-s-return>") 'open-previous-line)

;;; move deleted file to trash bin
(setq delete-by-moving-to-trash t)

;; (setq cursor-type 'bar)
(put 'dired-find-alternate-file 'disabled nil)

;;; set shell mode
(defun shell-mode-hook ()
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2))
(add-hook 'sh-mode-hook 'shell-mode-hook)

;;; set javascript mode
(setq js-indent-level 2)

;;; set color theme
(setq color-theme-is-global nil)
(defun color-theme-undo ()
  (interactive)
  (color-theme-reset-faces)
  (color-theme-snapshot))

;; backup current color theme
(fset 'color-theme-snapshot (color-theme-make-snapshot))

;;; set chinese font
(defun set-my-font (frame)
  (set-fontset-font (frame-parameter frame 'font) 'han '("STHeiTi" . "unicode-bmp")))

(defun hide-menu-bar-line-in-console ()
  (if (display-graphic-p)
      (modify-frame-parameters frame '((menu-bar-lines . 1)))
    (modify-frame-parameters frame '((menu-bar-lines . 0)))))

(require 'server)
(defun my-frame-config (frame)
  (if (server-running-p)
      (with-selected-frame frame
	(if (display-graphic-p)
	    (progn
	      (set-my-font frame)
	      (color-theme-merbivore))
	  (color-theme-undo))
	(blink-cursor-mode)
	(hide-menu-bar-line-in-console))))

(my-frame-config (selected-frame))
(add-hook 'after-make-frame-functions 'my-frame-config)

;;; For standalone window mode
;; (color-theme-merbivore)
;; (set-my-font nil)
