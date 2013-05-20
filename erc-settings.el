(require 'erc-hl-nicks)
(require 'erc-image)
(require 'erc-terminal-notifier)

(setq erc-autojoin-channels-alist
          '(("freenode.net" "##ability" "#rubyonrails.fr")))

(erc :server "irc.freenode.net" :port 6667 :nick "julienXX")
(erc :server "localhost" :port 6667 :nick "julien@tigerlilyapps.com")

(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(setq erc-max-buffer-size 3000)

(defvar erc-insert-post-hook)
    (add-hook 'erc-insert-post-hook
              'erc-truncate-buffer)
    (setq erc-truncate-buffer-on-save t)
