;;; jxx-complete.el --- Clojure setup

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

(require 'use-package)
(use-package company
  :ensure t
  :defer t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-to-list 'company-backends)
  ;; Except when you're in term-mode.
  (setq company-global-modes '(not term-mode)))

(provide 'jxx-complete)
;;; jxx-complete.el ends here
