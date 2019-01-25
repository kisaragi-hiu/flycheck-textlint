# textlint integration with Flycheck

This repository used to host a Flycheck checker for textlint, originally written by Rob Stewart ([A textlint flycheck checker in Emacs](https://www.macs.hw.ac.uk/~rs46/posts/2018-12-29-textlint-flycheck.html)) and modified by me. After #1, `flycheck-textlint-checker` has been upstreamed, and this repository will only serve as a setup guide.

## Setup

Install textlint:

```sh
npm install --global textlint
```

And then install some [rules](https://github.com/textlint/textlint/wiki/Collection-of-textlint-rule) for textlint, for example:

```sh
npm install --global textlint-rule-max-comma
```

Now write a [config file](https://textlint.github.io/docs/configuring.html) to (for example) `~/.config/textlint/textlintrc.json`.

```json
{
    "rules": {
        "max-comma": true
    }
}
```

Then set `flycheck-textlint-config` to point to that file:

```elisp
(setq flycheck-textlint-config "~/.config/textlint/textlintrc.json")
```

Start editing in a text-mode or markdown-mode buffer. Sentences with over 4 commas will be underlined because of the `max-comma` rule that we installed.

![max-comma](https://github.com/kisaragi-hiu/flycheck-textlint/blob/master/max-comma.png)

## LaTeX support and textlint plugins

By default, textlint supports Markdown (`.md`) and text (`.txt`) files. To enable support for other formats, install a [textlint plugin](https://github.com/textlint/textlint/blob/master/docs/plugin.md) for the format, and add an entry to `flycheck-textlint-plugin-alist`:

```sh
npm install --global textlint-plugin-latex
```

```elisp
(add-to-list 'flycheck-textlint-plugin-alist '(tex-mode . "latex"))
```

The `car` for each entry is matched with `derived-mode-p`, so the `latex` plugin is still used in `latex-mode`.
