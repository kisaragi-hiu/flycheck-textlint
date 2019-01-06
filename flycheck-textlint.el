;;; flycheck-textlint.el --- textlint integration with Flycheck
;;; -*- lexical-binding: t; -*-

;; Authors: Rob Stewart <R.Stewart@hw.ac.uk>
;;          Kisaragi Hiu <mail@kisaragi-hiu.com>
;; URL: https://github.com/kisaragi-hiu/flycheck-textlint
;; Version: 1.1.0
;; Keywords: convenience languages tools
;; Package-Requires: ((flycheck "0.25"))

;; This file is NOT part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; textlint integration with Flycheck

;;; Code:

(require 'flycheck)

(flycheck-def-option-var flycheck-textlint-config-file
    (concat (getenv "HOME") "/.config/textlint/textlintrc.json")
    textlint
  "Path to textlint config file."
  :type 'file
  :safe #'stringp)

(flycheck-def-option-var flycheck-textlint-plugin-alist
    '((markdown-mode . "@textlint/markdown")
      (t . "@textlint/text"))
    textlint
  "Alist mapping major modes to textlint plugins."
  :type '(repeat (choice (cons symbol string)
                         (cons (const t) string))))

(flycheck-define-checker textlint
  "A linter for textlint."
  :command ("textlint"
            "--config" (eval flycheck-textlint-config-file)
            "--format" "unix"
            ;; get the first matching plugin from plugin-alist
            "--plugin" (eval (car (cl-remove-if
                                   #'booleanp
                                   (mapcar
                                    (lambda (item)
                                      (let ((mode (car item))
                                            (plugin (cdr item)))
                                        (if (or (and mode (booleanp mode)) ; mode is t
                                                (derived-mode-p mode))
                                            plugin
                                          nil)))
                                    flycheck-textlint-plugin-alist))))
            source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes
  ;; TODO: this list needs to somehow be customizable
  (text-mode markdown-mode latex-mode org-mode))

(add-to-list 'flycheck-checkers 'textlint)

(provide 'flycheck-textlint)
;;; flycheck-textlint.el ends here
