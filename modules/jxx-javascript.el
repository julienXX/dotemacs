;;; jxx-javascript.el --- JS stuff

;; Copyright (C) 2017 Julien Blanchard

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

;;; Code:

(require 'use-package)
(use-package js2-mode
  :mode ("\\.js$" . js2-mode)
  :ensure js2-mode
  :config
  (setq js2-highlight-level 3)
  (defvar js-indent-level
    (setq js-indent-level 2))
  (setq js2-basic-offset 2))


(provide 'jxx-javascript)
;;; jxx-javascript.el ends here
