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
 '(initial-frame-alist (quote ((menu-bar-lines . 1) (top . 10) (left . 180) (width . 80) (height . 55))))
 '(initial-scratch-message ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

")
 '(large-file-warning-threshold nil)
 '(org-agenda-files (quote ("~/Desktop/mine/notes/todo.org")))
 '(org-agenda-include-diary t)
 '(org-log-into-drawer t)
 '(safe-local-variable-values (quote ((Package . CCL) (Base . 10) (Syntax . Common-lisp) (Package . monitor)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Monaco")))))
(set-fontset-font (frame-parameter nil 'font)
		  'han '("STHeiTi" . "unicode-bmp"))

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")


;;; AucTex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (setq TeX-engine 'xetex)
	    (TeX-global-PDF-mode t) ; PDF mode enable, not plain
	    (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
(setq TeX-auto-save t)
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2010/bin/universal-darwin:/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/texlive/2010/bin/universal-darwin"))) 
(setq exec-path (append exec-path '("/usr/local/bin"))) 

;;; Muse
(require 'muse-init)

;;; Emacs general behavior setup
(setq backup-inhibited t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq user-full-name "Huang Liang")
(setq user-mail-address "lhuang@thoughtworks.com")

;;Allow you to type just "y" instead of "yes" when you exit
(fset 'yes-or-no-p 'y-or-n-p) 
;;set auto fill mode
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;;; Buffer switch
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(require 'ebs)
(ebs-initialize)
(global-set-key [(control tab)] 'ebs-switch-buffer)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; Set recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
(global-set-key (kbd "M-P") 'recent-jump-backward)
(global-set-key (kbd "M-N") 'recent-jump-forward)
(require 'recent-jump)

;;; Ruby and rails
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-keys))

(add-to-list 'load-path "~/.emacs.d/elpa/ruby-compilation-0.7")
(autoload 'ruby-compilation "ruby-compilation" "ruby compilation" t)

(add-to-list 'load-path "~/.emacs.d/elpa/ruby-test-mode-1.0")
(autoload 'ruby-test-mode "ruby-test-mode" "ruby test mode" t)

;;; Common Lisp with Slime
(set-language-environment "utf-8")

(add-to-list 'load-path "~/.emacs.d/slime")

;;; Note that if you save a heap image, the character
;;; encoding specified on the command line will be preserved,
;;; and you won't have to specify the -K utf-8 any more.
(setq inferior-lisp-program "/usr/local/bin/ccl -K utf-8")

(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)
(slime-setup '(slime-fancy slime-asdf))

(require 'mic-paren)
(paren-activate) 

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

;;; Set Aspell
(setq-default ispell-program-name "/opt/local/bin/aspell")

;;; Global key bindings
(global-set-key (kbd "s-t") 'ido-switch-buffer)
;; (global-set-key (kbd "s-q") 'quit-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") 'other-windows)
(global-set-key (kbd "s-f") 'ido-find-file)
(global-set-key (kbd "<kp-delete>") 'delete-char)
;; (global-set-key (kbd "s-g") 'keyboard-quit)

;;; Org mode key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
