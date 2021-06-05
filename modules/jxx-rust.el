;;; jxx-rust.el --- Rust setup

;; Copyright (C) 2016 Julien Blanchard

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

(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode)
  :ensure t
  :config
  (require 'racer)
  (require 'cargo)
  (require 'flycheck-rust)
  (setq racer-cmd "~/.cargo/bin/racer")
  (setq racer-rust-src-path "/home/julien/src/rust/src")
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
  (add-hook 'rust-mode-hook 'cargo-minor-mode))


(provide 'jxx-rust)
;;; jxx-rust.el ends here
