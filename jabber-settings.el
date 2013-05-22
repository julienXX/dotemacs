(require 'jabber)

(setq jabber-account-list
      '(("julien.blanchard75@gmail.com"
         (:network-server  . "talk.google.com")
         (:machine-alias   . "gmail")
         (:connection-type . ssl))
        ("julien@sideburns.eu"
         (:network-server  . "talk.google.com")
         (:machine-alias   . "sideburns")
         (:connection-type . ssl))
        ("julien@tigerlilyapps.com"
         (:network-server  . "talk.google.com")
         (:machine-alias   . "tigerlilyapps")
         (:connection-type . ssl))))
