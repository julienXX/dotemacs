;;; jxx-dotnet.el --- .NET setup

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

;;; Commentary:

;;; Code:

(require 'use-package)
(use-package dotnet
  :ensure t
  :config
  (add-hook 'csharp-mode-hook 'dotnet-mode)
  (add-hook 'fsharp-mode-hook 'dotnet-mode))

(use-package fsharp-mode
  :ensure t)

(use-package csharp-mode
  :ensure t)

(use-package omnisharp
  :ensure t
  :config
  (add-hook 'csharp-mode-hook 'omnisharp-mode)
  (define-key omnisharp-mode-map (kbd "<C-tab>") 'omnisharp-auto-complete)
  (define-key omnisharp-mode-map "." 'omnisharp-add-dot-and-auto-complete)
  (setq-local company-backends '(company-omnisharp)))

(provide 'jxx-dotnet)
;;; jxx-dotnet.el ends here
