# flycheck-textlint

[textlint](https://textlint.github.io/) integration with Flycheck.

## Install

### [`straight.el`](https://github.com/raxod502/straight.el)

```elisp
(straight-use-package '(flycheck-textlint :type git :host github :repo "kisaragi-hiu/flycheck-textlint"))
```

### Manually

Put `flycheck-textlint.el` under your `load-path`, then `(require 'flycheck-textlint)` in your init file.

## Setup

Install textlint:

```sh
npm install --global textlint
```

And then install some [rules](https://github.com/textlint/textlint/wiki/Collection-of-textlint-rule) for textlint, for example:

```sh
npm install --global textlint-rule-max-comma
```

Now write a [config file](https://textlint.github.io/docs/configuring.html); in our example:

```json
{"rules": {
    "max-comma": true
}}
```

Save it to the file that `flycheck-textlint-config-file` points to, and start editing in a text-mode or markdown-mode buffer. Sentences with over 4 commas will be underlined because of the `max-comma` rule that we installed.

![max-comma](https://github.com/kisaragi-hiu/flycheck-textlint/blob/master/max-comma.jpg)

## Customize

- `flycheck-textlint-config-file`: config file for textlint
