(require 'use-package)
(use-package company
  :ensure t
  :defer t
  :hook (after-init . global-company-mode)
  :config
  ;; Except when you're in term-mode.
  (setq company-global-modes '(not term-mode)))
