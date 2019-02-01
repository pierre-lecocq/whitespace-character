;;; whitespace-character.el --- Whitespace hack for highlighting characters at column -*- lexical-binding: t; -*-

;; Author: Pierre Lecocq <pierre.lecocq@gmail.com>
;; URL: https://github.com/pierre-lecocq/whitespace-character
;; Version: 0.1

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

;; Usage:

;; (whitespace-character-mode t)
;; (setq whitespace-line-column 80
;;       whitespace-style '(character ...))

;;; Code:

(defvar whitespace-character 'whitespace-character)
(make-obsolete-variable 'whitespace-character
                        "customize the face `whitespace-character' instead."
                        "24.4")

(defface whitespace-character
  '((((class mono)) :inverse-video t)
    (t :background "red"))
  "Face used to visualize the character at `whitespace-line-column'."
  :group 'whitespace)

;;;###autoload
(define-minor-mode whitespace-character-mode
  "Whitespace hack for highlighting characters at column."
  :global t
  (when whitespace-character-mode
    (require 'whitespace)

    (defun whitespace-character-color-on ()
      "Turn on character color visualization."
      (when (whitespace-style-face-p)
        (setq whitespace-font-lock-keywords
              `((whitespace-point--flush-used)
                ,@(when (memq 'character whitespace-active-style)
                    `((,(format "^\\(.\\)\\{%d\\}" (+ whitespace-line-column 1)) 1 whitespace-character t)))))
        (font-lock-add-keywords nil whitespace-font-lock-keywords t)
        (font-lock-flush)))

    (add-hook #'whitespace-mode-hook #'whitespace-character-color-on)
    (add-hook #'global-whitespace-mode-hook #'whitespace-character-color-on)))

(provide 'whitespace-character)

;;; whitespace-character.el ends here
