;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(canlock-password "2a9b439ac3a993b3c39916308e7b69fdca5357dc")
 '(custom-safe-themes
   '("92c6de0850bb66a5e917de9c1e80f0baa0e5b88e74b2c2cd1e25f875a69de7a7"
     "835d934a930142d408a50b27ed371ba3a9c5a30286297743b0d488e94b225c5f"
     "96005f97499f0549f921f81588f190f189b7acb8bbebbcbb9033cdd340118f80"
     "f56e81765ccd0ee403860bd1d0a2f9967aa132b4a6f40517dd5eb13f7726eaba"
     default))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(ace-jump-mode agent-shell all-the-icons-ivy anzu backward-forward
                   cape cargo copilot corfu counsel crux deft delight
                   diminish dired-git-info diredfl dumb-jump
                   elfeed-protocol elpher emojify exec-path-from-shell
                   expand-region flycheck-rust focus forge gist
                   git-gutter golden-ratio ivy-hydra ivy-prescient
                   mastodon moody mu4e-alert mu4e-column-faces
                   multi-term multiple-cursors nerd-icons org-download
                   org-roam org-superstar popwin pulsar rbenv
                   rspec-mode ruby-tools rustic smartparens smex
                   soft-morning-theme treesit-auto typescript-mode
                   undo-tree unkillable-scratch wrap-region))
 '(safe-local-variable-values
   '((eglot-workspace-configuration lambda (arg)
                                    (when
                                        (string-match-p "gopls"
                                                        (format "%s"
                                                                (or
                                                                 arg
                                                                 "")))
                                      (list
                                       (cons "gopls"
                                             (list
                                              (intern
                                               ":build.directoryFilters")
                                              (vector "-bazel-bin"
                                                      "-bazel-out"
                                                      "-bazel-testlogs"
                                                      "-bazel-entropy")
                                              (intern ":build.env")
                                              (list
                                               (intern ":GOFLAGS")
                                               "-mod=mod")
                                              (intern
                                               ":formatting.gofumpt")
                                              t
                                              (intern
                                               ":formatting.local")
                                              "github.com/livestorm/entropy"
                                              (intern
                                               ":ui.semanticTokens")
                                              t
                                              (intern ":ui.codelenses")
                                              (list
                                               (intern ":gc_details")
                                               :json-false
                                               (intern
                                                ":regenerate_cgo")
                                               :json-false
                                               (intern ":generate")
                                               :json-false
                                               (intern ":test")
                                               :json-false
                                               (intern ":tidy")
                                               :json-false
                                               (intern
                                                ":upgrade_dependency")
                                               :json-false
                                               (intern ":vendor")
                                               :json-false))))))))
 '(smtpmail-smtp-server "mail.typed-hole.org")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gnus-header-content ((t (:foreground "light coral")))))
