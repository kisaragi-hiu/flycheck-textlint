# flycheck-textlint

[textlint](https://textlint.github.io/) integration with Flycheck.

Much of the code is from [A textlint flycheck checker in Emacs](https://www.macs.hw.ac.uk/~rs46/posts/2018-12-29-textlint-flycheck.html) by Rob Stewart.

## Install

### With [`straight.el`](https://github.com/raxod502/straight.el)

```elisp
(straight-use-package '(flycheck-textlint :type git :host github :repo "kisaragi-hiu/flycheck-textlint"))
```

### Manually

Put `flycheck-textlint.el` under your `load-path`, then `(require 'flycheck-textlint)` in your init file.

## LaTeX support and textlint plugins

By default, textlint supports Markdown (`.md`) and text (`.txt`) files. To enable support for other formats, install a [textlint plugin](https://github.com/textlint/textlint/blob/master/docs/plugin.md) for the format, and add an entry to `flycheck-textlint-plugin-alist`:

```sh
npm install --global textlint-plugin-latex
```

```elisp
(add-to-list 'flycheck-textlint-plugin-alist '(tex-mode . "latex"))
```

Note that the car for each entry is matched with `derived-mode-p`, so the `latex` plugin is still used in `latex-mode`.

## Customize

- `flycheck-textlint-config-file`: path to textlint config file
- `flycheck-textlint-plugin-alist`: map major modes to textlint plugins

## Setup

Install textlint:

```sh
npm install --global textlint
```

And then install some [rules](https://github.com/textlint/textlint/wiki/Collection-of-textlint-rule) for textlint, for example:

```sh
npm install --global textlint-rule-max-comma
```

Now write a [config file](https://textlint.github.io/docs/configuring.html) to `~/.config/textlint/textlintrc.json` (the default used in `flycheck-textlint.el`).

```json
{
    "rules": {
        "max-comma": true
    }
}
```

Start editing in a text-mode or markdown-mode buffer. Sentences with over 4 commas will be underlined because of the `max-comma` rule that we installed.

![max-comma](https://github.com/kisaragi-hiu/flycheck-textlint/blob/master/max-comma.png)
