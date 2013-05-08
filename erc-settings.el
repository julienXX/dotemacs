(require 'erc-hl-nicks)
(require 'erc-image)

(setq erc-autojoin-channels-alist
          '(("freenode.net" "##ability" "#rubyonrails.fr")
            ("localhost" "#dev" "#the_tigerlily_lobby")))

(erc :server "irc.freenode.net" :port 6667 :nick "julienXX")
;; (erc :server "localhost" :port 6667 :nick "Julien_Blanchard")

(setq erc-hide-list '("JOIN" "PART" "QUIT"))
