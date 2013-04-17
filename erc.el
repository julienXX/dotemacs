(setq erc-autojoin-channels-alist
          '(("freenode.net" "##ability" "#rubyonrails.fr" "#nethack")
            ("localhost" "543383")))
(erc :server "irc.freenode.net" :port 6667 :nick "julienXX")
(erc :server "localhost" :port 6667 :nick "julien")
