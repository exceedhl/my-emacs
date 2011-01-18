(defun tweakemacs-delete-region-or-char ()
  "Delete a region or a single character."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (delete-char 1)))
(global-set-key (kbd "C-d") 'tweakemacs-delete-region-or-char)

(defun tweakemacs-backward-delete-region-or-char ()
  "Backward delete a region or a single character."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (backward-delete-char 1)))
(global-set-key [backspace] 'tweakemacs-backward-delete-region-or-char)

(defun tweakemacs-duplicate-one-line ()
  "Duplicate the current line. There is a little bug: when current line is the last line of the buffer, this will not work as expected. Anyway, that's ok for me."
  (interactive)
  (let ((start (progn (beginning-of-line) (point)))
	(end (progn (next-line 1) (beginning-of-line) (point))))
    (insert-buffer-substring (current-buffer) start end)
    (forward-line -1)))
(global-set-key (kbd "C-=") 'tweakemacs-duplicate-one-line)

(defun tweakemacs-delete-one-line ()
  "Delete current line."
  (interactive)
  (beginning-of-line)
  (kill-line)
  (kill-line))
(global-set-key "\M-o" 'tweakemacs-delete-one-line)

(defun tweakemacs-move-one-line-downward ()
  "Move current line downward once."
  (interactive)
  (forward-line)
  (transpose-lines 1)
  (forward-line -1))
(global-set-key [C-M-down] 'tweakemacs-move-one-line-downward)

(defun tweakemacs-move-one-line-upward ()
  "Move current line upward once."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))
(global-set-key [C-M-up] 'tweakemacs-move-one-line-upward)

;; There is a bug in the uncomment-region. When you select
;; the last line of the buffer and if that is a comment, 
;; uncomment-region to that region will throw an error: Can't find the comment end.
;; Because I use uncomment-region here, so this command also has this bug.
(defun tweakemacs-comment-dwim-region-or-one-line (arg)
  "When a region exists, execute comment-dwim, or if comment or uncomment the current line according to if the current line is a comment."
  (interactive "*P")
  (if mark-active
      (comment-dwim arg)
    (save-excursion
      (let ((has-comment? (progn (beginning-of-line) (looking-at (concat "\\s-*" (regexp-quote comment-start))))))
	(push-mark (point) nil t) 
	(end-of-line)
	(if has-comment?
	    (uncomment-region (mark) (point))
	  (comment-region (mark) (point)))))))
(global-set-key (kbd "C-/") 'tweakemacs-comment-dwim-region-or-one-line)

(defun tweakemacs-indent-buffer ()
  "Mark whole buffer and indent."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-region (point) (mark) nil)))
(global-set-key (kbd "C-M-\\") 'tweakemacs-indent-buffer)





(require 'snippet)
(add-hook 'php-mode-hook
          (lambda()
            (local-set-key (kbd "<tab>")
                           '(lambda() (interactive)
			      (if snippet
				  (snippet-next-field)
				(if (looking-at "\\>")
				    (hippie-expand nil)
				  (indent-according-to-mode)))))))
