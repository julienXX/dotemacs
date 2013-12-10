;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
 (add-to-list 'auto-mode-alist        '("\\.rb$" . enh-ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("\\.rake$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("\\.thor$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("\\.gemspec$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("\\.ru$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("\\.rabl$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Rakefile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Thorfile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Gemfile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Procfile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Capfile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        '("Vagrantfile$" . enh-ruby-mode))
 (add-to-list 'auto-mode-alist        (cons "\\.erb$" #'rhtml-mode))

;; Golang
(add-to-list 'auto-mode-alist (cons "\\.go$" #'go-mode))

;; We never want to edit Rubinius bytecode or MacRuby binaries
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".rbo")

;; Treat some files as shell scripts
(add-to-list 'auto-mode-alist '(".gitconfig$" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".zshenv$" . shell-script-mode))

;; Markdown
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdn"   . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown"    . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md"       . markdown-mode))

;; Javascript
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))

;; RESTClient
(add-to-list 'auto-mode-alist '("\\.http" . restclient-mode))

;; Elixir
(add-to-list 'auto-mode-alist '("\\.exs" . elixir-mode))
