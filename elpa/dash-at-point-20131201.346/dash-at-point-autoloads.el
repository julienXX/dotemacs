;;; dash-at-point-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "dash-at-point" "dash-at-point.el" (21151 22875
;;;;;;  0 0))
;;; Generated autoloads from dash-at-point.el

(let ((loads (get 'dash-at-point 'custom-loads))) (if (member '"dash-at-point" loads) nil (put 'dash-at-point 'custom-loads (cons '"dash-at-point" loads))))

(defvar dash-at-point-mode-alist '((actionscript-mode . "actionscript") (arduino-mode . "arduino") (c++-mode . "cpp") (c-mode . "c") (clojure-mode . "clojure") (coffee-mode . "coffee") (common-lisp-mode . "lisp") (cperl-mode . "perl") (css-mode . "css") (elixir-mode . "elixir") (emacs-lisp-mode . "elisp") (erlang-mode . "erlang") (gfm-mode . "markdown") (go-mode . "go") (groovy-mode . "groovy") (haskell-mode . "haskell") (html-mode . "html") (java-mode . "java") (js2-mode . "javascript") (js3-mode . "nodejs") (less-css-mode . "less") (lua-mode . "lua") (markdown-mode . "markdown") (objc-mode . "iphoneos") (perl-mode . "perl") (php-mode . "php") (processing-mode . "processing") (puppet-mode . "puppet") (python-mode . "python3") (ruby-mode . "ruby") (sass-mode . "sass") (scala-mode . "scala") (vim-mode . "vim")) "\
Alist which maps major modes to Dash docset tags.
Each entry is of the form (MAJOR-MODE . DOCSET-TAG) where
MAJOR-MODE is a symbol and DOCSET-TAG is a corresponding tag
for one or more docsets in Dash.")

(custom-autoload 'dash-at-point-mode-alist "dash-at-point" t)

(defvar dash-at-point-docsets (mapcar #'cdr dash-at-point-mode-alist) "\
Variable used to store all known Dash docsets. The default value
is a collection of all the values from `dash-at-point-mode-alist'.

Setting or appending this variable can be used to add completion
options to `dash-at-point-with-docset'.")

(defvar dash-at-point-docset nil "\
Variable used to specify the docset for the current buffer.
Users can set this to override the default guess made using
`dash-at-point-mode-alist', allowing the docset to be determined
programatically.

For example, Ruby on Rails programmers might add an \"allruby\"
tag to the Rails, Ruby and Rubygems docsets in Dash, and then add
code to `rinari-minor-mode-hook' or `ruby-on-rails-mode-hook'
which sets this variable to \"allruby\" so that Dash will search
the combined docset.")

(autoload 'dash-at-point "dash-at-point" "\
Search for the word at point in Dash.
If the optional prefix argument EDIT-SEARCH is specified,
the user will be prompted to edit the search string first.

\(fn &optional EDIT-SEARCH)" t nil)

(autoload 'dash-at-point-with-docset "dash-at-point" "\
Search for the word at point in Dash with a chosen docset.
The docset options are suggested from the variable
`dash-at-point-docsets'.

If the optional prefix argument EDIT-SEARCH is specified,
the user will be prompted to edit the search string after
choosing the docset.

\(fn &optional EDIT-SEARCH)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; dash-at-point-autoloads.el ends here
