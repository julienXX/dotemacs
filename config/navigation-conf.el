(require 'use-package)
(use-package xref)

(use-package dumb-jump
  :ensure t
  :config
  (require 'xref)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
  )
