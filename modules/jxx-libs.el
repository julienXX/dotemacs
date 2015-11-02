;;; jxx-libs.el --- Base functions

;; Copyright (C) 2015 Julien Blanchard

;; Author: Julien Blanchard <julien@sideburns.eu>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:


(defun jxx/exec (command)
  "Run a shell command and return its output as a string, whitespace trimmed."
  (s-trim (shell-command-to-string command)))

(defun jxx/is-exec (command)
  "Returns true if `command' is an executable on the system search path."
  (f-executable? (s-trim (shell-command-to-string (s-concat "which " command)))))

(defun jxx/resolve-exec (command)
  "If `command' is an executable on the system search path, return its absolute path.
Otherwise, return nil."
  (-let [path (s-trim (shell-command-to-string (s-concat "which " command)))]
    (when (f-executable? path) path)))

(defun jxx/exec-if-exec (command args)
  "If `command' satisfies `jxx/is-exec', run it with `args' and return its
output as per `jxx/exec'. Otherwise, return nil."
  (when (jxx/is-exec command) (jxx/exec (s-concat command " " args))))

(defun jxx/getent (user)
  "Get the /etc/passwd entry for the user `user' as a list of strings,
or nil if there is no such user. Empty fields will be represented as nil,
as opposed to empty strings."
  (-let [ent (jxx/exec (s-concat "getent passwd " user))]
    (when (not (s-blank? ent))
      (-map (lambda (i) (if (s-blank? i) nil i))
            (s-split ":" ent)))))

(defun jxx/user-full-name ()
  "Guess the user's full name. Returns nil if no likely name could be found."
  (or (jxx/exec-if-exec "git" "config --get user.name")
      (elt (jxx/getent (getenv "USER")) 4)))

(defun jxx/user-email ()
  "Guess the user's email address. Returns nil if none could be found."
  (or (jxx/exec-if-exec "git" "config --get user.email")
      (getenv "EMAIL")))


(provide 'jxx-libs)
;;; jxx-libs.el ends here
