;;; clj-mode.el --- basic Major mode (clj) for Clojure code

;; Copyright (c) 2007-2008 Jeffrey Chu, Lennart Staflin, 2013 Matthew A. Grisius
;;
;; Authors: Jeffrey Chu <jochu0@gmail.com>
;;          Lennart Staflin <lenst@lysator.liu.se>
;; Author:  Matthew A. Grisius (mag) <mgrisius@acm.org>
;; URL: http://github.com/mgrisius/clj-mode
;; Version: 0.9
;; Keywords: languages, lisp, Clojure, clj
;; This file is not part of GNU Emacs.

;;; Commentary:

;; April 2013 - http://github.com/mgrisius/clj-mode
;; Derived from orginal version 1.0 of clojure-mode at: http://www.emacswiki.org/emacs/clojure-mode.el
;; Basic syntax highlighting/formatting/navigation for clojure (http://clojure.org).
;; Rename to clj-mode to preserve original clojure-mode.el version 1.0 'branch' of
;; 2007-2008 before references to it totally disappear, and to avoid name conflicts,
;; update to clojure 1.5.1, minor cleanup, and simplify/fix a few small issues.
;; Used on Win7 (emacs v24.2.1), Mac OSX 10.7.n (emacs v24.2.1, v23.3.1,
;; aquamacs v23.3.50.1), SuSe 11/12 (emacs v22.3.1, 24.2.1), etc.
;; Starting with clojure-mode.el v1.0 the form count for clj-mode update is:
;; v1.0 same:         14
;; v1.0 minor update:  4
;; mag new:            5 (4 defun, 1 defconst)

;;; Installation:

;; (0) Add this file to your load-path or use your own method.
;; (1) clj-mode assumes user sets inferior-lisp-program and handles
;;     other version/package dependencies external to this mode:
;;     e.g. paredit, AutoComplete, RainbowDelimiters, etc.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(eval-when-compile
  (defvar calculate-lisp-indent-last-sexp)
  (defvar font-lock-beg)
  (defvar font-lock-end)
  (require 'cl)
  (require 'comint)
  (require 'imenu)
  (require 'inf-lisp)
  (require 'thingatpt))

;; 1.0 same
(defgroup clj-mode nil
  "A mode for Clojure"
  :prefix "clj-mode-"
  :group 'applications)

;; 1.0 same
(defcustom clj-mode-load-command  "(clojure/load-file \"%s\")\n"
  "*Format-string for building a Clojure expression to load a file.
This format string should use `%s' to substitute a file name
and should result in a Clojure expression that will command the inferior
Clojure process to load that file."
  :type 'string
  :group 'clj-mode)

;; 1.0 same
(defcustom clj-mode-use-backtracking-indent t
  "Set to non-nil to enable backtracking/context sensitive indentation."
  :type 'boolean
  :group 'clj-mode)

;; 1.0 same
(defcustom clj-max-backtracking 3
  "Maximum amount to backtrack up a list to check for context."
  :type 'integer
  :group 'clj-mode)

;; 1.0 same
;; (comment...) subtle font-lock/nav issues exist
;; also does not handle '#_' 'Ignore next form' Reader form
;; these are not new issues and need more thought.
(defcustom clj-mode-font-lock-comment-sexp nil
  "Set to non-nil in order to enable font-lock of (comment...)
forms. This option is experimental. Changing this will require a
restart (ie. M-x clj-mode) of existing clj mode buffers."
  :type 'boolean
  :group 'clj-mode)

;; 1.0 same
(defvar clj-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map lisp-mode-shared-map)
    (define-key map "\e\C-x"   'lisp-eval-defun)
    (define-key map "\C-x\C-e" 'lisp-eval-last-sexp)
    (define-key map "\C-c\C-e" 'lisp-eval-last-sexp)
    (define-key map "\C-c\C-l" 'clj-load-file)
    (define-key map "\C-c\C-r" 'lisp-eval-region)
    (define-key map "\C-c\C-z" 'run-lisp)
    map)
  "Keymap for ordinary clj mode.
All commands in `lisp-mode-shared-map' are inherited by this map.")

;; 1.0 minor update
(defvar clj-mode-syntax-table
  (let ((table (copy-syntax-table emacs-lisp-mode-syntax-table)))
    (modify-syntax-entry ?~  "'"  table)
    (modify-syntax-entry ?\{ "(}" table)
    (modify-syntax-entry ?\} "){" table)
    (modify-syntax-entry ?\[ "(]" table)
    (modify-syntax-entry ?\] ")[" table)
    (modify-syntax-entry ?^  "'"  table)
    table))

;; 1.0 same
(defvar clj-prev-l/c-dir/file nil
  "Record last directory and file used in loading or compiling.
This holds a cons cell of the form `(DIRECTORY . FILE)'
describing the last `clj-load-file' or `clj-compile-file' command.")

;; mag new
;; clojure-match-next-def d/n work correctly.
;; using `clojure-1.4.0/src/clj/clojure/core.clj' as a test use case
;; over 20 of 571 defs or ~4% are missing from index, plus erroneous entries too!
;; NOTE: imenu treats any number of dashes, e.g. '-', '--', etc. as menu separators
;; or horizontal lines so the function name '-' d/n appear in the imenu popup, they
;; do however appear in m-x imenu buffer completion window . . .
(defun clj-mode-next-def ()
  "Scans the buffer backwards for the next top-level definition."
  (when (re-search-backward "^(def\\sw*" nil t)
    (save-excursion
      (let ((def-name nil)
	    (start (point)))
	(down-list)
	(forward-sexp)
	(while (not def-name)
	  (forward-sexp)
	  (or (if (char-equal ?\[ (char-after (point)))
		  (backward-sexp))
	      (if (char-equal ?\) (char-after (point)))
		  (backward-sexp)))
	  (destructuring-bind (def-beg . def-end) (bounds-of-thing-at-point 'sexp)
	    (if (not (char-equal ?^ (char-after def-beg)))
		(progn (setq def-name t) (set-match-data (list def-beg def-end)))
	      (progn (forward-sexp) (backward-sexp)))))
	(goto-char start)))))

;; mag new
(defun clj-mode-variables ()
  (setq imenu-create-index-function
  	(lambda ()
  	  (imenu--generic-function '((nil clj-mode-next-def 0)))))
  ;; enable alphabetic sorting, instead of buffer order
  (setq imenu-sort-function 'imenu--sort-by-name)
  (defvar clj-mode-abbrev-table nil
    "Abbrev table used in clj-mode buffers.")
  (set (make-local-variable 'font-lock-multiline) t)
  (define-abbrev-table 'clj-mode-abbrev-table ())
  (setq local-abbrev-table clj-mode-abbrev-table)
  (setq indent-tabs-mode nil)
  (set-syntax-table clj-mode-syntax-table)
  ;; use lisp-mode.el regexp
  (set (make-local-variable 'comment-start-skip)
       "\\(\\(^\\|[^\\\\\n]\\)\\(\\\\\\\\\\)*\\);+ *")
  (set (make-local-variable 'lisp-indent-function)
       'clj-indent-function)
  (set (make-local-variable 'parse-sexp-ignore-comments) t)
  (add-to-list 'font-lock-extend-region-functions
               'clj-font-lock-extend-region-def t)
  ;; optional font-lock "comment" forms
  (when clj-mode-font-lock-comment-sexp
    (add-to-list 'font-lock-extend-region-functions
                 'clj-font-lock-extend-region-comment t)
    (make-local-variable 'clj-font-lock-keywords)
    (add-to-list 'clj-font-lock-keywords
                 'clj-font-lock-mark-comment t)
    (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))
  ;; "search based fontification" setup
  (setq font-lock-defaults
        '(clj-font-lock-keywords ; keywords
          nil nil ; syntactic fontification, case insensitive
          (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist, #?
          nil ; syntax begin
	  ;; Other vars
          (font-lock-mark-block-function . mark-defun)
          (font-lock-syntactic-face-function . lisp-font-lock-syntactic-face-function))))

;; mag new
;;;###autoload
(defun clj-mode ()
  "Major mode for editing Clojure code - similar to Lisp mode.
Commands:
Delete converts tabs to spaces as it moves back.
Blank lines separate paragraphs.  Semicolons start comments.
\\{clj-mode-map}
Note that `run-lisp' may be used either to start an inferior Lisp process
or to switch back to an existing one.

Entry to this mode calls the value of `clj-mode-hook'
if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (use-local-map clj-mode-map)
  (setq major-mode 'clj-mode)
  (setq mode-name "clj")
  (lisp-mode-variables nil)
  (clj-mode-variables)
  ;; run 'normal' mode hooks for this mode
  (run-mode-hooks 'clj-mode-hook))

;; 1.0 same
(defun clj-font-lock-def-at-point (point)
  "Find the position range between the top-most def* and the
fourth element afterwards. Note that this means there's no
gaurantee of proper font locking in def* forms that are not at
top-level."
  (goto-char point)
  (condition-case nil
      (beginning-of-defun)
    (error nil))
  (let ((beg-def (point)))
    (when (and (not (= point beg-def))
               (looking-at "(def"))
      (condition-case nil
	  (progn
	    ;; move forward as much as possible until failure (or success)
	    (forward-char)
	    (dotimes (i 4)
	      (forward-sexp)))
	(error nil))
      (cons beg-def (point)))))

;; 1.0 same
(defun clj-font-lock-extend-region-def ()
  "Move fontification boundaries to always include the first four
elements of a def* forms."
  (let ((changed nil))
    (let ((def (clj-font-lock-def-at-point font-lock-beg)))
      (when def
	(destructuring-bind (def-beg . def-end) def
	  (when (and (< def-beg font-lock-beg)
		     (< font-lock-beg def-end))
	    (setq font-lock-beg def-beg
		  changed t)))))
    (let ((def (clj-font-lock-def-at-point font-lock-end)))
      (when def
	(destructuring-bind (def-beg . def-end) def
	  (when (and (< def-beg font-lock-end)
		     (< font-lock-end def-end))
	    (setq font-lock-end def-end
		  changed t)))))
    changed))

;; 1.0 same
(defun clj-font-lock-extend-region-comment ()
  "Move fontification boundaries to always contain
  entire (comment ..) sexp. Does not work if you have a
  white-space between ( and comment, but that is omitted to make
  this run faster."
  (let ((changed nil))
    (goto-char font-lock-beg)
    (condition-case nil (beginning-of-defun) (error nil))
    (let ((pos (re-search-forward "\\((comment\\>\\)" font-lock-end t)))
      (when pos
        (forward-char -8)
        (when (< (point) font-lock-beg)
          (setq font-lock-beg (point)
                changed t))
        (condition-case nil (forward-sexp) (error nil))
        (when (> (point) font-lock-end)
	  (setq font-lock-end (point)
                changed t))))
    changed))

;; 1.0 same
(defun clj-font-lock-mark-comment (limit)
  "Marks all (comment ..) forms with font-lock-comment-face."
  (let (pos)
    (while (and (< (point) limit)
                (setq pos (re-search-forward "\\((comment\\>\\)" limit t)))
      (when pos
	(forward-char -8)
        (condition-case nil
	    (add-text-properties
	     (point)
	     (progn (forward-sexp) (point))
	     '(comment t face font-lock-comment-face multiline t))
          (error (forward-char 8)))))
    nil))

;; 1.0 same
(defun clj-load-file (file-name)
  "Load a Lisp file into the inferior Lisp process."
  (interactive (comint-get-source "Load Clojure file: "
				  clj-prev-l/c-dir/file
				  '(clj-mode) t))
  (comint-check-source file-name) ; Check to see if buffer needs saving.
  (setq clj-prev-l/c-dir/file (cons (file-name-directory file-name)
				    (file-name-nondirectory file-name)))
  (comint-send-string (inferior-lisp-proc)
		      (format clj-mode-load-command file-name))
  (switch-to-lisp t))

;; 1.0 minor update (string change, code same)
(defun clj-indent-function (indent-point state)
  "This function is the normal value of the variable `lisp-indent-function'.
It is used when indenting a line within a function call, to see if the
called function says anything special about how to indent the line.

INDENT-POINT is the position where the user typed TAB, or equivalent.
Point is located at the point to indent under (for default indentation);
STATE is the `parse-partial-sexp' state for that position.

If the current line is in a call to a Lisp function
which has a non-nil property `lisp-indent-function',
that specifies how to do the indentation.  The property value can be
* `defun', meaning indent `defun'-style;
* an integer N, meaning indent the first N arguments specially
  like ordinary function arguments and then indent any further
  arguments like a body;
* a function to call just as this function was called.
  If that function returns nil, that means it doesn't specify
  the indentation.

This function also returns nil meaning don't specify the indentation."
  (let ((normal-indent (current-column)))
    (goto-char (1+ (elt state 1)))
    (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
    (if (and (elt state 2)
             (not (looking-at "\\sw\\|\\s_")))
        ;; car of form doesn't seem to be a symbol
        (progn
          (if (not (> (save-excursion (forward-line 1) (point))
                      calculate-lisp-indent-last-sexp))
	      (progn (goto-char calculate-lisp-indent-last-sexp)
		     (beginning-of-line)
		     (parse-partial-sexp (point)
					 calculate-lisp-indent-last-sexp 0 t)))
	  ;; Indent under the list or under the first sexp on the same
	  ;; line as calculate-lisp-indent-last-sexp.  Note that first
	  ;; thing on that line has to be complete sexp since we are
          ;; inside the innermost containing sexp.
          (backward-prefix-chars)
          (if (and (eq (char-after (point)) ?\[)
                   (eq (char-after (elt state 1)) ?\())
              (+ (current-column) 2) ;; this is probably inside a defn
            (current-column)))
      (let ((function (buffer-substring (point)
					(progn (forward-sexp 1) (point))))
            (open-paren (elt state 1))
	    method)
	(setq method (get (intern-soft function) 'clj-indent-function))
	(cond ((member (char-after open-paren) '(?\[ ?\{))
	       (goto-char open-paren)
               (1+ (current-column)))
	      ((or (eq method 'defun)
		   (and (null method)
			(> (length function) 3)
			;; minor update in regexp
			(string-match "\\`\\(?:\\S +/\\)?def\\|with-" function)))
	       (lisp-indent-defform state indent-point))
	      ((integerp method)
	       (lisp-indent-specform method state
				     indent-point normal-indent))
	      (method
	       (funcall method indent-point state))
              (clj-mode-use-backtracking-indent
               (clj-backtracking-indent indent-point state normal-indent)))))))

;; 1.0 same
(defun clj-backtracking-indent (indent-point state normal-indent)
  "Was experimental backtracking support in 2008, appears to be default now.
Will navigate upwards in an sexp to check for contextual indenting."
  (let (indent (path) (depth 0))
    (goto-char (elt state 1))
    (while (and (not indent)
                (< depth clj-max-backtracking))
      (let ((containing-sexp (point)))
        (parse-partial-sexp (1+ containing-sexp) indent-point 1 t)
        (when (looking-at "\\sw\\|\\s_")
          (let* ((start (point))
                 (fn (buffer-substring start (progn (forward-sexp 1) (point))))
                 (meth (get (intern-soft fn) 'clj-backtracking-indent)))
            (let ((n 0))
              (when (< (point) indent-point)
                (condition-case ()
                    (progn
		      (forward-sexp 1)
		      (while (< (point) indent-point)
			(parse-partial-sexp (point) indent-point 1 t)
			(incf n)
			(forward-sexp 1)))
                  (error nil)))
              (push n path))
            (when meth
              (let ((def meth))
                (dolist (p path)
                  (if (and (listp def)
                           (< p (length def)))
                      (setq def (nth p def))
                    (if (listp def)
                        (setq def (car (last def)))
                      (setq def nil))))
                (goto-char (elt state 1))
                (when def
                  (setq indent (+ (current-column) def)))))))
        (goto-char containing-sexp)
        (condition-case ()
            (progn
              (backward-up-list 1)
              (incf depth))
          (error (setq depth clj-max-backtracking)))))
    indent))

;; clojure-backtracking-indent was experimental and the format for these
;; entries were subject to change, but code hasn't changed since v1.0 (2008)
(put 'defprotocol     'clj-backtracking-indent '(4 (2)))
(put 'defrecord       'clj-backtracking-indent '(4 4 (2)))
(put 'deftype         'clj-backtracking-indent '(4 4 (2)))
(put 'extend-protocol 'clj-backtracking-indent '(4 (2)))
(put 'extend-type     'clj-backtracking-indent '(4 (2)))
(put 'letfn           'clj-backtracking-indent '((2) 2))
(put 'proxy           'clj-backtracking-indent '(4 4 (2)))
(put 'reify           'clj-backtracking-indent '((2)))

;; 1.0 minor update
(defun put-clj-indent (sym indent)
  (put sym 'clj-indent-function indent))

;; 1.0 same
(defmacro define-clj-indent (&rest kvs)
  `(progn
     ,@(mapcar (lambda (x) `(put-clj-indent (quote ,(first x)) ,(second x))) kvs)))

;; 1.0 minor update
(define-clj-indent
  (assoc 1)
  (binding 1) (bound-fn 'defun)
  (case 1) (catch 2) (comment 0) (condp 2)
  (def 'defun) (defmethod 'defun) (defmulti 1) (defn 'defun) (defprotocol 1) (deftest 'defun)
  (deftype 2) (defrecord 2) (defstruct 1) (do 0) (dotimes 1) (doto 1) (doseq 1)
  (extend 1) (extend-protocol 1) (extend-type 1)
  (finally 0) (fn 'defun) (for 1) (future 0)
  (if 1) (if-let 1) (if-not 1)
  (let 1) (letfn 1) (locking 1) (loop 1)
  (ns 1)
  (proxy 2)
  (reify 'defun)
  (struct-map 1)
  (testing 1) (try 0)
  (use-fixtures 'defun) ; ??
  (when 1) (when-first 1) (when-let 1) (when-not 1) (while 1) (with-open 1)
  (with-precision 1) (with-local-vars 1))

;; clj specific faces
(copy-face     'bold 'clj-builtin-face)
(set-face-foreground 'clj-builtin-face  "MediumOrchid4")
;;
(copy-face     'bold 'clj-keyword-face)
(set-face-foreground 'clj-keyword-face  "Purple")
;;
(copy-face     'bold 'clj-special-face)
(set-face-foreground 'clj-special-face  "#b8bb00")
;;
(copy-face  'default 'clj-userdef-face)
(set-face-foreground 'clj-userdef-face  "DarkSlateGrey")
;;
(copy-face     'bold 'clj-usergv-face)
(set-face-foreground 'clj-usergv-face   "DarkSlateGrey")
;;
(copy-face     'bold 'clj-note-face)
(set-face-foreground 'clj-note-face     "Orange")
;;
(copy-face     'bold 'clj-type-face)
(set-face-foreground 'clj-type-face     "ForestGreen")

;; mag new
(defconst clj-other-namespaces ; used twice in 'other-namespaces' below
  '("data" "edn" "inspector" "instant" "main" "pprint" "reflect" "repl"
    "set" "stacktrace" "string" "template" "test" "walk" "xml" "zip"))

(defconst clj-font-lock-keywords
  (eval-when-compile
    `( ;; clojure.core Defs.
      (,(concat
	 "(\\(?:clojure\.core/\\)?\\("
	 (regexp-opt
	  '("defn" "def" "defn-" "defmacro" "defmulti" "defmethod" "definterface"
	    "defstruct" "deftype" "defprotocol" "defrecord" "definline" "defonce"))
	 "\\)\\>"
	 ;; optional whitespace
	 "[ \n\t]*"
	 ;; optional type or metadata
	 "\\(?:#?^\\(?:{[^}]*}\\|\\sw+\\)[ \n\t]*\\)*"
	 "\\(\\sw+\\)?")
       (1 font-lock-keyword-face)
       (2 font-lock-function-name-face nil t))
      ;; (fn name? args ...)
      (,(concat
	 "(\\(?:clojure\.core/\\)?\\(fn\\)[ \n\t]+"
	 ;; optional type (needs more thought)
	 "\\(?:#?^\\sw+[ \n\t]*\\)?"
	 "\\(\\sw+\\)?" )
       (1 font-lock-keyword-face)
       (2 font-lock-function-name-face nil t))
      ;; NOTE these to the user, perhaps other '!' forms too? There are 16 others!
      ("(\\(new\\|memfn\\|declare\\|set!\\|dosync\\|io!\\)" 1 'clj-note-face)
      ;; clojure.core Control structures, Special Forms, and Macros
      (,(concat
         "(\\(?:clojure\.core/\\)?"
         (regexp-opt
          '("->" "->>" "." ".." "and" "binding" "case" "catch" "comment" "cond" "cond->" 
	    "cond->>" "condp" "do" "doall" "doc" "dorun" "doseq" "dotimes" "doto" "finally" 
	    "for" "gen-class" "gen-interface" "if" "if-let" "if-not" "import" "in-ns" "let" 
	    "letfn" "load" "load-file" "locking" "loop" "macroexpand" "macroexpand-1" 
	    "monitor-enter" "monitor-exit" "ns" "or" "proxy" "proxy-call-with-super" 
	    "proxy-super" "quote" "recur" "refer" "throw" "time" "try" "when" "when-first" 
	    "when-let" "when-not" "while" "with-bindings" "with-bindings*" "with-in-str" 
	    "with-loading-context" "with-local-vars" "with-meta" "with-open" "with-out-str" 
	    "with-precision" "with-redefs" "with-redefs-fn") t)
         "\\>")
       1 font-lock-keyword-face)
      ;; clojure.core Built-ins, w/ Defs, Control Structures, Special Forms, and Macros removed.
      (,(concat
         "(\\(?:clojure\.core/\\)?"
         (regexp-opt
          '("*" "*'" "+" "+'" "-" "-'" "->ArrayChunk" "->Vec" "->VecNode" "->VecSeq" 
	    "-cache-protocol-fn" "-reset-methods" "/" "<" "<=" "=" "==" ">" ">=" "accessor" 
	    "aclone" "add-classpath" "add-watch" "agent" "agent-error" "agent-errors" 
	    "aget" "alength" "alias" "all-ns" "alter" "alter-meta!" "alter-var-root" "amap" 
	    "ancestors" "apply" "areduce" "array-map" "as->" "aset" "aset-boolean" 
	    "aset-byte" "aset-char" "aset-double" "aset-float" "aset-int" "aset-long" 
	    "aset-short" "assert" "assoc!" "assoc" "assoc-in" "associative?" "atom" "await" 
	    "await-for" "await1" "bases" "bean" "bigdec" "bigint" "biginteger" "bit-and" 
	    "bit-and-not" "bit-clear" "bit-flip" "bit-not" "bit-or" "bit-set" 
	    "bit-shift-left" "bit-shift-right" "bit-test" "bit-xor" "boolean" 
	    "boolean-array" "booleans" "bound-fn" "bound-fn*" "bound?" "butlast" "byte" 
	    "byte-array" "bytes" "cast" "char" "char-array" "char-escape-string" 
	    "char-name-string" "char?" "chars" "chunk" "chunk-append" "chunk-buffer" 
	    "chunk-cons" "chunk-first" "chunk-next" "chunk-rest" "chunked-seq?" "class" 
	    "class?" "clear-agent-errors" "clojure-version" "coll?" "commute" "comp" 
	    "comparator" "compare" "compare-and-set!" "compile" "complement" "concat" 
	    "conj!" "conj" "cons" "constantly" "construct-proxy" "contains?" "count" 
	    "counted?" "create-ns" "create-struct" "cycle" "dec" "dec'" "decimal?" 
	    "default-data-readers" "delay" "delay?" "deliver" "denominator" "deref" 
	    "derive" "descendants" "destructure" "disj!" "disj" "dissoc!" "dissoc" 
	    "distinct" "distinct?" "double" "double-array" "doubles" "drop" "drop-last" 
	    "drop-while" "empty" "empty?" "ensure" "enumeration-seq" "error-handler" 
	    "error-mode" "eval" "even?" "every-pred" "every?" "ex-data" "ex-info" "extend" 
	    "extend-protocol" "extend-type" "extenders" "extends?" "false?" "ffirst" 
	    "file-seq" "filter" "filterv" "find" "find-keyword" "find-ns" 
	    "find-protocol-impl" "find-protocol-method" "find-var" "first" "flatten" 
	    "float" "float-array" "float?" "floats" "flush" "fn" "fn?" "fnext" "fnil" 
	    "force" "format" "frequencies" "future" "future-call" "future-cancel" 
	    "future-cancelled?" "future-done?" "future?" "gensym" "get" "get-in" 
	    "get-method" "get-proxy-class" "get-thread-bindings" "get-validator" "group-by" 
	    "hash" "hash-combine" "hash-map" "hash-set" "identical?" "identity" "ifn?" 
	    "inc" "inc'" "init-proxy" "instance?" "int" "int-array" "integer?" "interleave" 
	    "intern" "interpose" "into" "into-array" "ints" "isa?" "iterate" "iterator-seq" 
	    "juxt" "keep" "keep-indexed" "key" "keys" "keyword" "keyword?" "last" 
	    "lazy-cat" "lazy-seq" "line-seq" "list" "list*" "list?" "load-reader" 
	    "load-string" "loaded-libs" "long" "long-array" "longs" "make-array" 
	    "make-hierarchy" "map" "map-indexed" "map?" "mapcat" "mapv" "max" "max-key" 
	    "memoize" "merge" "merge-with" "meta" "method-sig" "methods" "min" "min-key" 
	    "mod" "munge" "name" "namespace" "namespace-munge" "neg?" "newline" "next" 
	    "nfirst" "nil?" "nnext" "not" "not-any?" "not-empty" "not-every?" "not=" 
	    "ns-aliases" "ns-imports" "ns-interns" "ns-map" "ns-name" "ns-publics" 
	    "ns-refers" "ns-resolve" "ns-unalias" "ns-unmap" "nth" "nthnext" "nthrest" 
	    "num" "number?" "numerator" "object-array" "odd?" "parents" "partial" 
	    "partition" "partition-all" "partition-by" "pcalls" "peek" "persistent!" "pmap" 
	    "pop!" "pop" "pop-thread-bindings" "pos?" "pr" "pr-str" "prefer-method" 
	    "prefers" "primitives-classnames" "print" "print-ctor" "print-dup" 
	    "print-method" "print-simple" "print-str" "printf" "println" "println-str" 
	    "prn" "prn-str" "promise" "proxy-mappings" "proxy-name" "push-thread-bindings" 
	    "pvalues" "quot" "rand" "rand-int" "rand-nth" "range" "ratio?" "rational?" 
	    "rationalize" "re-find" "re-groups" "re-matcher" "re-matches" "re-pattern" 
	    "re-seq" "read" "read-line" "read-string" "realized?" "reduce" "reduce-kv" 
	    "reduced" "reduced?" "reductions" "ref" "ref-history-count" "ref-max-history" 
	    "ref-min-history" "ref-set" "refer-clojure" "reify" "release-pending-sends" 
	    "rem" "remove" "remove-all-methods" "remove-method" "remove-ns" "remove-watch" 
	    "repeat" "repeatedly" "replace" "replicate" "require" "reset!" "reset-meta!" 
	    "resolve" "rest" "restart-agent" "resultset-seq" "reverse" "reversible?" "rseq" 
	    "rsubseq" "satisfies?" "second" "select-keys" "send" "send-off" "send-via" 
	    "seq" "seq?" "seque" "sequence" "sequential?" "set" "set-agent-send-executor!" 
	    "set-agent-send-off-executor!" "set-error-handler!" "set-error-mode!" 
	    "set-validator!" "set?" "short" "short-array" "shorts" "shuffle" 
	    "shutdown-agents" "slurp" "some" "some->" "some->>" "some-fn" "sort" "sort-by" 
	    "sorted-map" "sorted-map-by" "sorted-set" "sorted-set-by" "sorted?" 
	    "special-symbol?" "spit" "split-at" "split-with" "str" "string?" "struct" 
	    "struct-map" "subs" "subseq" "subvec" "supers" "swap!" "symbol" "symbol?" 
	    "sync" "take" "take-last" "take-nth" "take-while" "test" "the-ns" 
	    "thread-bound?" "to-array" "to-array-2d" "trampoline" "transient" "tree-seq" 
	    "true?" "type" "unchecked-add" "unchecked-add-int" "unchecked-byte" 
	    "unchecked-char" "unchecked-dec" "unchecked-dec-int" "unchecked-divide-int" 
	    "unchecked-double" "unchecked-float" "unchecked-inc" "unchecked-inc-int" 
	    "unchecked-int" "unchecked-long" "unchecked-multiply" "unchecked-multiply-int" 
	    "unchecked-negate" "unchecked-negate-int" "unchecked-remainder-int" 
	    "unchecked-short" "unchecked-subtract" "unchecked-subtract-int" "underive" 
	    "unquote" "unquote-splicing" "update-in" "update-proxy" "use" "val" "vals" 
	    "var-get" "var-set" "var?" "vary-meta" "vec" "vector" "vector-of" "vector?" 
	    "xml-seq" "zero?" "zipmap") t)
         "\\>")
       1 font-lock-builtin-face)
      ;; clojure.core Vars
      (,(concat
         "\\(?:clojure\.core/\\)?"
         (regexp-opt
          '("*1" "*2" "*3" "*agent*" "*allow-unresolved-vars*" "*assert*handle"
	    "handler-case" "*clojure-version*" "*command-line-args*" "*compile-files*"
	    "*compile-path*" "*compiler-options*" "*data-readers*"
	    "*default-data-reader-fn*" "*e" "*err*" "*file*" "*flush-on-newline*"
	    "*fn-loader*" "*in*" "*math-context*" "*ns*" "*out*" "*print-dup*"
	    "*print-length*" "*print-level*" "*print-meta*" "*print-readably*"
	    "*read-eval*" "*source-path*" "*unchecked-math*" "*use-context-classloader*"
	    "*verbose-defrecords*" "*warn-on-reflection*") t)
         "\\>")
       1 'clj-builtin-face)
      ;; Built-ins from other namespaces
      (,(concat
         ;; d/n enforce true namespace, but narrows candidates
	 "(\\(?:clojure\."
	 (regexp-opt clj-other-namespaces)
	 "/\\)?"
         (regexp-opt
          '("->AsmReflector" "->Constructor" "->Field" "->JavaReflector" "->Method"
	    "ClassResolver" "Diff" "EqualityPartition" "Reflector" "TypeReference"
	    "append-child" "apply-template" "apropos" "are" "assert-any" "assert-expr"
	    "assert-predicate" "atom?" "attrs" "blank?" "branch?" "capitalize" "children"
	    "cl-format" "code-dispatch" "collection-tag" "compose-fixtures" "content"
	    "content-handler" "deftest" "deftest-" "demunge" "diff" "diff-similar"
	    "difference" "dir" "dir-fn" "do-reflect" "do-report" "do-template" "doc" "down"
	    "e" "edit" "element" "emit" "emit-element" "end?" "equality-partition" "escape"
	    "file-position" "find-doc" "flag-descriptors" "formatter" "formatter-out"
	    "fresh-line" "function?" "get-child" "get-child-count"
	    "get-possibly-unbound-var" "get-pretty-writer" "inc-report-counter" "index"
	    "insert-child" "insert-left" "insert-right" "inspect" "inspect-table"
	    "inspect-tree" "intersection" "is" "is-leaf" "join" "join-fixtures"
	    "keywordize-keys" "left" "leftmost" "lefts" "list-model" "list-provider"
	    "load-script" "lower-case" "macroexpand-all" "main" "make-node"
	    "map->Constructor" "map->Field" "map->Method" "map-invert" "next" "node"
	    "old-table-model" "parse" "parse-timestamp" "path" "postwalk" "postwalk-demo"
	    "postwalk-replace" "pp" "pprint" "pprint-indent" "pprint-logical-block"
	    "pprint-newline" "pprint-tab" "prev" "prewalk" "prewalk-demo" "prewalk-replace"
	    "print-cause-trace" "print-length-loop" "print-stack-trace" "print-table"
	    "print-throwable" "print-trace-element" "project" "pst" "re-quote-replacement"
	    "read" "read-instant-calendar" "read-instant-date" "read-instant-timestamp"
	    "read-string" "reflect" "remove" "rename" "rename-keys" "repl" "repl-caught"
	    "repl-exception" "repl-prompt" "repl-read" "repl-requires" "replace"
	    "replace-first" "report" "resolve-class" "reverse" "right" "rightmost" "rights"
	    "root" "root-cause" "run-all-tests" "run-tests" "select" "seq-zip"
	    "set-break-handler!" "set-pprint-dispatch" "set-test" "simple-dispatch"
	    "skip-if-eol" "skip-whitespace" "source" "source-fn" "split" "split-lines"
	    "stack-element-str" "startparse-sax" "stringify-keys" "subset?" "successful?"
	    "superset?" "table-model" "tag" "test-all-vars" "test-ns" "test-var" "testing"
	    "testing-contexts-str" "testing-vars-str" "thread-stopper" "tree-model" "trim"
	    "trim-newline" "triml" "trimr" "try-expr" "type-reflect" "typename" "union"
	    "up" "upper-case" "use-fixtures" "validated" "vector-zip" "walk"
	    "with-bindings" "with-pprint-dispatch" "with-read-known" "with-test"
	    "with-test-out" "write" "write-out" "xml-zip" "zipper") t)
         "\\>")
       1 font-lock-type-face)
      ;; Vars from other namespaces
      (,(concat
	 ;; d/n enforce true namespace, but narrows candidates
	 "(\\(?:clojure\."
	 (regexp-opt clj-other-namespaces)
	 "/\\)?"
         (regexp-opt
          '("*current*" "*initial-report-counters*" "*load-tests*" "*print-base*"
	    "*print-miser-width*" "*print-pprint-dispatch*" "*print-pretty*"
	    "*print-radix*" "*print-right-margin*" "*print-suppress-namespaces*"
	    "*report-counters*" "*sb*" "*stack*" "*stack-trace-depth*" "*state*"
	    "*test-out*" "*testing-contexts*" "*testing-vars*") t)
         "\\>")
       1 'clj-type-face)
      ;; userdefs
      (,(concat
	 "(\\(?:\\sw+/\\)?\\(def\\sw+-?\\)\\>" ; needs more thought.
      	 ;; optional whitespace
      	 "[ \n\t]*"
      	 ;; optional type or metadata
      	 "\\(?:#?^\\(?:{[^}]*}\\|\\sw+\\)[ \n\t]*\\)*"
      	 "\\(\\sw+\\)?")
       (1 'clj-userdef-face)
       (2 font-lock-function-name-face nil t))
      ;; misc highlighting - NOTE font-lock-preprocessor-face is just font-lock-builtin-face
      ("\\<\\(true\\|false\\|nil\\|%[1-9]?\\)\\>" 0 'clj-special-face) ; brian carper
      ;; Quoted Words tend to be symbol names.
      ("'\\(\\sw+\\)" 1 font-lock-constant-face prepend)
      ;; usergvs
      ("\\<\\*\\sw+\\*\\>" . 'clj-usergv-face)
      ;; The rest still need more thought (from clojure-mode.el)
      ;; Constant values (keywords), including as metadata e.g. ^:static
      ("\\<^?:\\(\\sw\\|#\\)+\\>" 0 font-lock-constant-face)
      ;; Meta type annotation #^Type or ^Type
      ("#?^\\sw+" 0 font-lock-preprocessor-face)
      ;;Java interop highlighting
      ;; .foo .barBaz .qux01 .-flibble .-flibbleWobble
      ("\\<\\.-?[a-z][a-zA-Z0-9]*\\>" 0 font-lock-preprocessor-face)
      ;; Foo Bar$Baz Qux_ World_OpenUDP
      ("\\<[A-Z][a-zA-Z0-9_]*[a-zA-Z0-9/$_]+\\>" 0 font-lock-preprocessor-face)
      ;; fix e.g. for java.awt.image.BufferedImage/TYPE_INT_RGB
      ;; Foo/Bar foo.bar.Baz foo.Bar/baz
      ("\\<[a-zA-Z]+\\.[a-zA-Z0-9._/]*[A-Z]+[a-zA-Z0-9/.$_]*\\>" 0 font-lock-preprocessor-face)
      ;; fooBar
      ("[a-z]*[A-Z]+[a-z][a-zA-Z0-9$]*\\>" 0 font-lock-preprocessor-face)
      ;; Foo. BarBaz. Qux$Quux. Corge9.
      ("\\<[A-Z][a-zA-Z0-9$]*\\.\\>" 0 font-lock-preprocessor-face)))
  "Default expressions to highlight in clj mode.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.clj$" . clj-mode))

(provide 'clj-mode)
;;; clj-mode.el ends here
