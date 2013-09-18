;;; magit-commit-training-wheels.el --- Advice for magit-log-edit-commit

;; Copyright (C) 2012 @re5et

;; Author: atom smith
;; URL: https://github.com/re5et/magit-commit-training-wheels
;; Created: 23 Dec 2012
;; Version: 20130730.1032
;; X-Original-Version: 0.0.1
;; Keywords: magit

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Helps you craft well formed commit messages with magit's log edit
;; commit.  Directives for what makes a well formed commit come from
;; tpope: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

;;; Code:

(require 'magit)

(defadvice magit-log-edit-commit (around magit-commit-training-wheels activate)
  "Make sure we have a nice commit message."
  (let ((ok-to-commit t)
        (commit-problems nil)
        (case-fold-search nil))
    (save-excursion
      (beginning-of-buffer)
      (re-search-forward "^-- End of Magit header --\n" nil t)
      (when (and (looking-at "[a-z]")
		 (yes-or-no-p "First line doesn't start with a capital letter.  Fix? "))
	(capitalize-word 1))
      (end-of-line)
      (when (> (current-column) 50)
	(add-to-list 'commit-problems "First line is too long (> 50 characters)."))
      (when (> (count-lines (point) (point-max)) 0)
	(forward-line)
	(when (and (not (equal (point-at-bol) (point-at-eol)))
		   (yes-or-no-p "Doesn't have a blank line after the first.  Fix? "))
	  (newline))
	(while (not (equal (point) (point-max)))
	  (forward-line)
	  (end-of-line)
	  (when (> (current-column) 72)
	    (add-to-list 'commit-problems
			 "There are lines that are too long (> 72 characters)"))))
      (when commit-problems
	(catch 'break
	  (dolist (problem commit-problems)
	    (unless (yes-or-no-p (concat problem "  Commit anyway? "))
	      (setq ok-to-commit nil)
	      (throw 'break nil))))))
    (when ok-to-commit
      ad-do-it)))

(provide 'magit-commit-training-wheels)
;;; magit-commit-training-wheels.el ends here
