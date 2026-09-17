;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Disable GUI
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box t)
(setq use-file-dialog nil)

;; initial frame size
(add-to-list 'default-frame-alist '(left . 10))
(add-to-list 'default-frame-alist '(top . 10))
(add-to-list 'default-frame-alist '(height . 52))
(add-to-list 'default-frame-alist '(width . 180))

;;; early-init.el ends here
