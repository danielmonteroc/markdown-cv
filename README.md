# Daniel Montero Cervantes - Resume

The resume is maintained in Markdown and rendered directly to PDF with Pandoc and the Tectonic LaTeX engine.

## Requirements

- [Pandoc](https://pandoc.org/)
- [Tectonic](https://tectonic-typesetting.github.io/)

On macOS with Homebrew:

```sh
brew install pandoc tectonic
```

## Build

From the repository root:

```sh
pandoc --defaults pandoc.yaml
```

The command reads `resume.md` and creates `resume.pdf`. Layout and typography are defined in `template.tex`.

GitHub Pages serves the static `index.html`, which opens the generated PDF. The `.nojekyll` file disables the Jekyll build step.

This repository was originally based on [elipapa/markdown-cv](https://github.com/elipapa/markdown-cv) and remains available under the MIT License.
