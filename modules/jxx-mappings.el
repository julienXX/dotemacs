;;; jxx-mappings.el --- Keyboard mapping

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

;;; Code:

(global-set-key (kbd "C-c s")        'shell)
(global-set-key (kbd "C-x C-v")      'ido-find-file-other-window)
(global-set-key (kbd "C-c c")        'switch-to-previous-buffer)
(global-set-key (kbd "M-T")          'textmate-goto-symbol)
(global-set-key (kbd "C-c d")        'duplicate-line)
(global-set-key (kbd "M-]")          'textmate-shift-right)
(global-set-key (kbd "M-[")          'textmate-shift-left)
(global-set-key (kbd "M-/")          'comment-or-uncomment-region)
(global-set-key (kbd "C-x à")        'delete-window)
(global-set-key (kbd "C-x &")        'delete-other-windows)
(global-set-key (kbd "C-x é")        'split-window-below)
(global-set-key (kbd "C-x \"")       'split-window-right)
(global-set-key (kbd "M-L")          'textmate-select-line)
(global-set-key (kbd "C-c g")        'magit-status)
(global-set-key (kbd "M-l")          'goto-line-with-feedback)
(global-set-key (kbd "M-z")          'zap-up-to-char)
(global-set-key (kbd "C-x -")        'toggle-windows-split)
(global-set-key (kbd "<f12>")        'multi-term-dedicated-toggle)
(global-set-key (kbd "C-c ,,")       'ruby-open-spec-other-buffer)
(global-set-key (kbd "<C-S-down>")   'move-line-down)
(global-set-key (kbd "<C-S-up>")     'move-line-up)
(global-set-key (kbd "<C-return>")   'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)
(global-set-key (kbd "M-.")          'dumb-jump-go)
(global-set-key (kbd "M-p")          'previous-multiframe-window)
(global-set-key (kbd "M-n")          'other-window)
(global-set-key (kbd "C-ù")          'mark-all-words-like-this)
(global-set-key "\C-s"               'swiper)
(global-set-key (kbd "C-c C-r")      'ivy-resume)
(global-set-key (kbd "<f6>")         'ivy-resume)
(global-set-key (kbd "M-x")          'counsel-M-x)
(global-set-key (kbd "M-t")          'counsel-projectile-find-file)
(global-set-key (kbd "C-x C-f")      'counsel-find-file)
(global-set-key (kbd "C-x b")        'ivy-switch-buffer)
(global-set-key (kbd "C-c j")        'counsel-git-grep)
(global-set-key (kbd "C-c k")        'counsel-ripgrep)
(global-set-key (kbd "M-y")          'counsel-yank-pop)
(global-set-key (kbd "M-SPC")        'avy-goto-char)

(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key swiper-map (kbd "C-s")
  (lambda () (interactive) (insert (format "\\<%s\\>" (with-ivy-window (thing-at-point 'symbol))))))
(define-key swiper-map (kbd "M-s")
  (lambda () (interactive) (insert (format "\\<%s\\>" (with-ivy-window (thing-at-point 'word))))))

(provide 'jxx-mappings)
;;; jxx-mappings.el ends here
