;;; jxx-modes.el --- Modes config

;; Copyright (C) 2017 Julien Blanchard

;; Author: Julien Blanchard <julien@sideburns.eu>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

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

;; JSON
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

;; RESTClient
(add-to-list 'auto-mode-alist '("\\.http" . restclient-mode))

;; Elixir
(add-to-list 'auto-mode-alist '("\\.exs" . elixir-mode))

;; CoffeeScript
(add-to-list 'auto-mode-alist '("\\.coffee" . coffee-mode))

;; .NET
(add-to-list 'auto-mode-alist '("\\.fsproj" . fsharp-mode))


(provide 'jxx-modes)
;;; jxx-modes.el ends here
