(require 'jabber)
(load-file "~/.emacs.d/private.el")

(setq jabber-account-list
      '(("julien.blanchard75@gmail.com"
         (:password        . "artef@ct!")
         (:network-server  . "talk.google.com")
         (:machine-alias   . "gmail")
         (:connection-type . ssl))
        ("julien@sideburns.eu"
         (:password        . jabber-sideburns-password)
         (:network-server  . "talk.google.com")
         (:machine-alias   . "sideburns")
         (:connection-type . ssl))
        ("julien@tigerlilyapps.com"
         (:password        . jabber-tigerlily-password)
         (:network-server  . "talk.google.com")
         (:machine-alias   . "tigerlilyapps")
         (:connection-type . ssl))))

(custom-set-variables
 '(jabber-auto-reconnect t)
 '(jabber-avatar-verbose nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(jabber-chat-buffer-format "*-jabber-%n-*")
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-roster-buffer "*-jabber-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts nil)
)
