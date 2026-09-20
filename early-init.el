;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Disable GUI
(setq frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box t)
(setq use-file-dialog nil)

(unless (getenv "WAYLAND_DISPLAY")
  (pcase-let ((`(,left ,top ,width ,height)
               (if (eq system-type 'darwin)
                   '(40 40 1420 780)
                 '(150 150 1474 1053))))
    (add-to-list 'initial-frame-alist `(left . ,left))
    (add-to-list 'initial-frame-alist `(top . ,top))
    (add-to-list 'initial-frame-alist `(width . (text-pixels . ,width)))
    (add-to-list 'initial-frame-alist `(height . (text-pixels . ,height)))))

;;; early-init.el ends here
