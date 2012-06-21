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
(require 'yasnippet-bundle)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)
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

;; Wrap region
(require 'wrap-region)
(wrap-region-global-mode)

;; Twittering mode
(add-hook 'twittering-mode-hook
           (lambda ()
             (mapc (lambda (pair)
                     (let ((key (car pair))
                           (func (cdr pair)))
                       (define-key twittering-mode-map
                         (read-kbd-macro key) func)))
                   '(("F" . twittering-friends-timeline)
                     ("R" . twittering-replies-timeline)
                     ("U" . twittering-user-timeline)
                     ("W" . twittering-update-status-interactive)))))

(add-hook 'twittering-new-tweets-hook (lambda ()
   (let ((n twittering-new-tweets-count))
     (start-process "twittering-notify" nil "notify-send"
                    "-i" "/usr/share/pixmaps/gnome-emacs.png"
                    "New tweets"
                    (format "You have %d new tweet%s"
                            n (if (> n 1) "s" ""))))))

(setq twittering-icon-mode t)                ; Show icons
(setq twittering-timer-interval 300)         ; Update your timeline each 300 seconds (5 minutes)
(setq twittering-url-show-status nil)        ; Keeps the echo area from showing all the http processes

;; CTags
(autoload 'ctags-update-minor-mode "ctags-update" "update TAGS using ctags" t)
(ctags-update-minor-mode 1)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Gists
(require 'eieio)
(require 'gist)
(setq gist-use-curl t)
(setq gist-view-gist t)

;; Partially.el
(require 'partially)
(setq partially:rails-root-fn 'rinari-root)

;; ace-jump-mode
;;(require 'ace-jump-mode)
;;  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Ruby-electric
(require 'ruby-electric)

;; Workaround for ruby-electric messing with yasnippet
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))
(yas/advise-indent-function 'ruby-indent-line)

;; RESTclient
(require 'restclient)
