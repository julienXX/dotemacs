;;; jxx-gnus.el --- Gnus setup

;; Copyright (C) 2019 Julien Blanchard

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

;;; Commentary:

;;; Code:

(setq gnus-select-method
      '(nntp "orbitalfox"
             (nntp-address "orbitalfox.eu")
             (nntp-port-number 563)
             (nntp-open-connection-function
              nntp-open-tls-stream)))

(provide 'jxx-gnus)
;;; jxx-gnus.el ends here
