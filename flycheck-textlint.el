;;; flycheck-textlint.el --- textlint integration with Flycheck
;;; -*- lexical-binding: t; -*-

;; Authors: Rob Stewart <R.Stewart@hw.ac.uk>
;;          Kisaragi Hiu <mail@kisaragi-hiu.com>
;; URL: https://gitlab.com/kisaragi-hiu/flycheck-textlint
;; Version: 1.0.0
;; Keywords: convenience languages tools
;; Package-Requires: ((flycheck "0.25"))

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; textlint integration with Flycheck

;;; Code:

(require 'flycheck)

(flycheck-def-option-var
    flycheck-textlint-config-file
    (concat (getenv "HOME") "/.config/textlint/textlintrc.json")
    textlint
  "Path to textlint config file."
  :type 'file
  :safe #'stringp)

(flycheck-define-checker textlint
  "A linter for textlint."
  :command ("textlint"
            "--config" (eval flycheck-textlint-config-file)
            "--format" "unix"
            source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes
  (text-mode markdown-mode))

(add-to-list 'flycheck-checkers 'textlint)

(provide 'flycheck-textlint)
;;; flycheck-textlint.el ends here
