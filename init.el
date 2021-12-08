;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 100 1024 1024))

(require 'package)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-archive-priorities '(("melpa" . 2)
                                   ("gnu" . 1)))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'org)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 10 1000 1000))
;; (defun org-clocking-buffer (&rest _))
