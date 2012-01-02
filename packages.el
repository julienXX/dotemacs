;; add ido
(require 'ido)
(ido-mode)

;; smex
(require 'smex)
(smex-initialize)

;; smex bindings
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This the original M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; textmate mode
(require 'textmate)
(textmate-mode)

;; autopair
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;; project-mode
(autoload 'project-mode "project-mode" "Project Mode" t)

;; yasnippet
(require 'yasnippet)
(yas/global-mode 1)

;; peepopen
(require 'peepopen)

;; automatic end insertion
(require 'ruby-end)
