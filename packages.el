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

;; automatic end insertion
(require 'ruby-end)

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; Ack and a half
(add-to-list 'load-path "/elpa/ack-and-a-half")
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-samee "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
