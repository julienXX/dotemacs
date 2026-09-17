;;; jxx-modeline.el --- Minimal moody modeline with flymake diagnostics  -*- lexical-binding: t -*-

;; Author: Julien Blanchard
;; Keywords: faces, mode-line
;; Package-Requires: ((emacs "29.1") (moody "1.0"))

;;; Commentary:
;;
;; A three-segment mode line:
;;
;;   [!] |  icon  project/s/u/b/file.el  | 12:4
;;
;; 1. A flymake diagnostics glyph.  Clicking it lists the diagnostics and
;;    jumps to the chosen one.
;; 2. A `moody' tab holding the all-the-icons glyph for the buffer and a
;;    shortened path: the project name, one letter per directory, the file.
;; 3. Line and column.
;;
;; Enable with `jxx-modeline-mode'.  ivy and all-the-icons are optional;
;; they are used when loaded.

;;; Code:

(require 'moody)
(require 'project)
(require 'seq)
(require 'subr-x)
(require 'warnings)

(require 'flymake)
(declare-function ivy-read "ivy")
(declare-function all-the-icons-icon-for-file "all-the-icons")
(declare-function all-the-icons-icon-for-mode "all-the-icons")

(defgroup jxx-modeline nil
  "Minimal moody modeline with flymake diagnostics."
  :group 'mode-line)

;;;; Faces

(defface jxx-modeline-base
  '((t :background "#e2e2e5" :foreground "#4c4c4c"))
  "Base face; the other text faces inherit from it."
  :group 'jxx-modeline)

(defface jxx-modeline-filename
  '((t :inherit jxx-modeline-base :weight bold))
  "Buffer name."
  :group 'jxx-modeline)

(defface jxx-modeline-modified
  '((t :inherit jxx-modeline-base :foreground "#d08689" :weight bold))
  "Buffer name when the buffer has unsaved changes."
  :group 'jxx-modeline)

(defface jxx-modeline-icon
  '((t :weight normal))
  "Fallback attributes for the file icon.
Its glyph font and colour come from all-the-icons; anything left
unspecified there, like the weight, is taken from this face instead of
from `mode-line'."
  :group 'jxx-modeline)

(defface jxx-modeline-diag-error
  '((t :background "#d08689" :foreground "#ffffff" :weight bold))
  "Diagnostics glyph when there are errors."
  :group 'jxx-modeline)

(defface jxx-modeline-diag-warning
  '((t :background "#c9a227" :foreground "#ffffff"))
  "Diagnostics glyph when there are only warnings or notes."
  :group 'jxx-modeline)

(defface jxx-modeline-diag-ok
  '((t :background "#8aa234" :foreground "#ffffff"))
  "Diagnostics glyph when the buffer is clean."
  :group 'jxx-modeline)

;;;; Diagnostics
;; One list feeds both the modeline glyph and the picker.

(defconst jxx-modeline--severity-glyphs
  '((error . "!") (warning . "~") (info . "·"))
  "Diagnostic severities, worst first, with the glyph shown for each.")

(defun jxx-modeline--diagnostics ()
  "Flymake diagnostics of the current buffer as (SEVERITY MESSAGE DIAG) lists.
SEVERITY is `error', `warning' or `info'; DIAG is the flymake diagnostic."
  (when flymake-mode
    (mapcar (lambda (diag)
              (let ((severity (flymake--severity (flymake-diagnostic-type diag))))
                (list (cond ((> severity (warning-numeric-level :warning)) 'error)
                            ((> severity (warning-numeric-level :debug))   'warning)
                            (t 'info))
                      (flymake-diagnostic-text diag)
                      diag)))
            (flymake-diagnostics))))

(defun jxx-modeline--worst-severity (diagnostics)
  "Worst severity present in DIAGNOSTICS, or nil when there are none."
  (car (seq-find (lambda (entry) (assq (car entry) diagnostics))
                 jxx-modeline--severity-glyphs)))

(defun jxx-modeline-show-diagnostics ()
  "Pick one of the current buffer's diagnostics and jump to it.
Uses ivy when available, `completing-read' otherwise."
  (interactive)
  (let ((buf (current-buffer))
        (diagnostics (jxx-modeline--diagnostics)))
    (if (null diagnostics)
        (message "No diagnostics")
      (let* ((candidates
              (mapcar (pcase-lambda (`(,severity ,message ,diag))
                        (let ((pos (flymake-diagnostic-beg diag)))
                          (propertize (format "%s %4d:%-3d %s"
                                              (alist-get severity jxx-modeline--severity-glyphs)
                                              (line-number-at-pos pos)
                                              (save-excursion (goto-char pos) (current-column))
                                              message)
                                      'jxx-modeline-pos pos)))
                      diagnostics))
             (jump (lambda (candidate)
                     (with-current-buffer buf
                       (goto-char (get-text-property 0 'jxx-modeline-pos candidate))))))
        (if (fboundp 'ivy-read)
            (ivy-read "Diagnostics: " candidates
                      :action jump :caller 'jxx-modeline-show-diagnostics)
          (let ((choice (completing-read "Diagnostics: " candidates nil t)))
            (funcall jump (seq-find (lambda (c) (string= c choice)) candidates))))))))

(defvar jxx-modeline-diag-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line mouse-1] #'jxx-modeline-show-diagnostics)
    map)
  "Keymap of the diagnostics glyph.")

(defun jxx-modeline--diag-segment ()
  "Clickable glyph summarising the buffer's diagnostics, or nil.
The worst reported severity wins.  Otherwise \"✓\" once any backend has
reported a clean buffer, even if a slower one is still running, so a slow
or silent backend never hides a verdict.  \"…\" only while nothing has
reported yet, and nil when flymake is off or has no backend."
  (let* ((worst    (jxx-modeline--worst-severity (jxx-modeline--diagnostics)))
         ;; Both queries signal `user-error' until flymake has initialized.
         (running  (and flymake-mode (ignore-errors (flymake-running-backends))))
         (reported (and flymake-mode (ignore-errors (flymake-reporting-backends)))))
    (pcase-let ((`(,face . ,glyph)
                 (cond (worst    (cons (if (eq worst 'error)
                                           'jxx-modeline-diag-error
                                         'jxx-modeline-diag-warning)
                                       (alist-get worst jxx-modeline--severity-glyphs)))
                       (reported '(jxx-modeline-diag-ok . "✓"))
                       (running  '(jxx-modeline-base . "…")))))
      (when glyph
        (propertize (format " %s " glyph)
                    'face face
                    'local-map jxx-modeline-diag-map
                    'mouse-face 'mode-line-highlight)))))

;;;; Path and icon

(defun jxx-modeline--initials (dirs)
  "Join DIRS with \"/\", keeping only the first character of each."
  (mapconcat (lambda (dir) (substring dir 0 1)) dirs "/"))

(defun jxx-modeline-shrink-path (file)
  "Short display name for FILE.
Inside a project: PROJECT/s/u/b/file.  Elsewhere: ~/s/u/parent/file, with
every directory but the last shortened to its initial."
  (let* ((root (when-let* ((project (project-current nil (file-name-directory file))))
                 (expand-file-name (project-root project))))
         (dirs (split-string (or (file-name-directory
                                  (if root
                                      (file-relative-name file root)
                                    (abbreviate-file-name file)))
                                 "")
                             "/" t))
         (parts (if root
                    (list (file-name-nondirectory (directory-file-name root))
                          (jxx-modeline--initials dirs))
                  (list (jxx-modeline--initials (butlast dirs))
                        (car (last dirs))))))
    (string-join (seq-remove (lambda (part) (member part '(nil "")))
                             (append parts (list (file-name-nondirectory file))))
                 "/")))

;; Both caches are keyed on their input, so they refresh by themselves when
;; a buffer is renamed, saved under another name or changes major mode.

(defvar-local jxx-modeline--path-cache nil "(FILE . SHORT-PATH) of the last render.")
(defvar-local jxx-modeline--icon-cache nil "(FILE-OR-MODE . ICON) of the last render.")

(defmacro jxx-modeline--cached (cache key &rest body)
  "Value of BODY for KEY.
CACHE is a (KEY . VALUE) cons; VALUE is reused while KEY is unchanged."
  (declare (indent 2))
  (macroexp-let2 nil k key
    `(progn
       (unless (equal ,k (car ,cache))
         (setq ,cache (cons ,k (progn ,@body))))
       (cdr ,cache))))

(defun jxx-modeline--path ()
  "Shortened path of the visited file, or the buffer name."
  (if-let* ((file (buffer-file-name)))
      (jxx-modeline--cached jxx-modeline--path-cache file
        (jxx-modeline-shrink-path file))
    (buffer-name)))

(defun jxx-modeline--icon ()
  "Icon of the buffer from all-the-icons, in its own colour, or nil."
  (when (fboundp 'all-the-icons-icon-for-file)
    (let ((key (or (buffer-file-name) major-mode)))
      (jxx-modeline--cached jxx-modeline--icon-cache key
        (let ((icon (ignore-errors
                      (if (stringp key)
                          (all-the-icons-icon-for-file key)
                        (all-the-icons-icon-for-mode key)))))
          ;; `all-the-icons-icon-for-mode' returns the mode symbol when it has no icon.
          (when (and (stringp icon) (not (string-empty-p icon)))
            (add-face-text-property 0 (length icon) 'jxx-modeline-icon t icon)
            icon))))))

;;;; Moody

(defun jxx-modeline--moody-slant (&rest args)
  "Call `moody-slant' with ARGS and image smoothing disabled.
HiDPI (pgtk, `frame-scale-factor' 2): the slant XPMs are built in logical
pixels and then upscaled by the frame scale with bilinear smoothing.  The
smoothed edge blends with the placeholder's light background and draws a
thin pale outline around each slant.  Building slants at physical
resolution and never smoothing them fixes it."
  (let ((image-transform-smoothing nil))
    (apply #'moody-slant args)))

(defun jxx-modeline--setup-moody ()
  "Configure moody and the mode-line faces for tabs."
  (setq x-underline-at-descent-line t)
  (setq moody-display-scale (if (fboundp 'frame-scale-factor)
                                (max 1 (round (frame-scale-factor)))
                              1))
  (setq moody-slant-function #'jxx-modeline--moody-slant)
  ;; moody draws tabs as cut-outs of the mode-line background, so the bar must
  ;; be flat: no box or lines, and one colour whether the window is active or not.
  (dolist (face '(mode-line mode-line-inactive))
    (set-face-attribute face nil
                        :background (face-background 'jxx-modeline-base)
                        :box nil :overline nil :underline nil)))

;;;; Layout

(defun jxx-modeline--render ()
  "Modeline constructs: diagnostics glyph, tab with icon and path, line:column."
  (let* ((file (buffer-file-name))
         (pad  (propertize " " 'face 'jxx-modeline-base))
         (icon (jxx-modeline--icon))
         (name (propertize (format " %s " (jxx-modeline--path))
                           'face (if (and file (buffer-modified-p))
                                     'jxx-modeline-modified
                                   'jxx-modeline-filename)
                           'help-echo (or file (buffer-name)))))
    ;; A list, not a string: `moody-tab' returns constructs the mode-line
    ;; engine has to walk itself.  Its first element must not be a symbol,
    ;; or the engine reads the list as an (IF THEN ELSE) construct.
    (list (or (jxx-modeline--diag-segment) "")
          (propertize " " 'display '(space :width 4) 'face 'jxx-modeline-base)
          (moody-tab (concat (and icon (concat pad icon pad)) name) nil 'up)
          (propertize " %l:%c " 'face 'jxx-modeline-base))))

(defconst jxx-modeline-format
  '("%e" (:eval (condition-case err
                    (jxx-modeline--render)
                  (error (format " [modeline: %s] " (error-message-string err))))))
  "Value installed as the default `mode-line-format'.")

(defvar jxx-modeline--saved-format nil
  "Default `mode-line-format' before `jxx-modeline-mode' was enabled.")

;;;###autoload
(define-minor-mode jxx-modeline-mode
  "Use the jxx modeline as the default `mode-line-format'.
Buffers that set their own `mode-line-format' are left alone.  Disabling
restores the previous default but leaves the mode-line faces as configured."
  :global t
  :group 'jxx-modeline
  (if jxx-modeline-mode
      (progn
        (unless jxx-modeline--saved-format
          (setq jxx-modeline--saved-format (default-value 'mode-line-format)))
        (jxx-modeline--setup-moody)
        (setq-default mode-line-format jxx-modeline-format))
    (when jxx-modeline--saved-format
      (setq-default mode-line-format jxx-modeline--saved-format)
      (setq jxx-modeline--saved-format nil)))
  (force-mode-line-update t))

(provide 'jxx-modeline)
;;; jxx-modeline.el ends here
