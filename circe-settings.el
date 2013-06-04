(load-file "~/.emacs.d/private.el")

;; connection
(setq circe-network-options
      `(("Freenode"
         :nick "julienXX"
         :channels ("#emacs" "#putaindecode" "#clojure" "#erlang" "#erlang-fr" "#rubyonrails.fr")
         :nickserv-password freenode-password
         )))

;; hide join/part
(setq circe-reduce-lurker-spam t)

;; color nicks
(enable-circe-color-nicks)
