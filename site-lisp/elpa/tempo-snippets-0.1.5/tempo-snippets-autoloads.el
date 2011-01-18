;;; tempo-snippets-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (tempo-snippets-complete-tag tempo-snippets-insert-template
;;;;;;  tempo-define-snippet tempo-snippets-next-field tempo-snippets-previous-field
;;;;;;  tempo-snippets-clear-latest tempo-snippets-clear-oldest tempo-snippets-clear-all)
;;;;;;  "tempo-snippets" "tempo-snippets.el" (19610 21349))
;;; Generated autoloads from tempo-snippets.el

(autoload 'tempo-snippets-clear-all "tempo-snippets" "\
Clear all tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-clear-oldest "tempo-snippets" "\
Clear the oldest tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-clear-latest "tempo-snippets" "\
Clear the latest tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-previous-field "tempo-snippets" "\
Jump to the previous editable tempo-snippet field.
You can also use `tempo-forward-mark', which will include more points of
interest.

\(fn &optional ARG)" t nil)

(autoload 'tempo-snippets-next-field "tempo-snippets" "\
Jump to the next editable tempo-snippet field.
You can also use `tempo-backward-mark', which will include more points of
interest.

\(fn &optional ARG)" t nil)

(autoload 'tempo-define-snippet "tempo-snippets" "\
`tempo-snippets' version of `tempo-define-template'.
Use with the same arguments as `tempo-define-template'.  The resulting template
will prompt for input right in the buffer instead of the minibuffer.

\(fn NAME ELEMENTS &optional TAG DOCUMENTATION TAGLIST)" nil nil)

(autoload 'tempo-snippets-insert-template "tempo-snippets" "\
`tempo-snippets' version of `tempo-insert-template.'

\(fn TEMPLATE ON-REGION)" nil nil)

(autoload 'tempo-snippets-complete-tag "tempo-snippets" "\
`tempo-snippets' version of `tempo-complete-tag.'

\(fn &optional SILENT)" t nil)

;;;***

;;;### (autoloads nil nil ("tempo-snippets-pkg.el") (19610 21349
;;;;;;  700926))

;;;***

(provide 'tempo-snippets-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tempo-snippets-autoloads.el ends here
