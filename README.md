# Daniel Montero Cervantes - Resume

The resume is maintained in Markdown and rendered directly to PDF with Pandoc and the Tectonic LaTeX engine.

## Requirements

- [Pandoc](https://pandoc.org/)
- [Tectonic](https://tectonic-typesetting.github.io/)

On macOS with Homebrew:

```sh
brew install pandoc tectonic
```

## Build automatically

Each platform script installs Pandoc or Tectonic when either command is missing, then generates the PDF.

macOS with Homebrew:

```sh
./scripts/build-macos.sh
```

Arch Linux with pacman:

```sh
./scripts/build-linux.sh
```

Windows with Chocolatey:

```powershell
.\scripts\build-windows.ps1
```

With no arguments, the scripts convert `resume.md` to `resume.pdf`. They also set reproducible-build timestamps, so rebuilding unchanged content produces the same PDF. An alternative Markdown input and PDF output can be provided:

```sh
./scripts/build-macos.sh path/to/input.md path/to/output.pdf
```

```powershell
.\scripts\build-windows.ps1 -InputPath path\to\input.md -OutputPath path\to\output.pdf
```

## Build directly

From the repository root:

```sh
pandoc --defaults pandoc.yaml resume.md --output resume.pdf
```

The command reads `resume.md` and creates `resume.pdf`. Layout and typography are defined in `template.tex`.

GitHub Pages serves the static `index.html`, which opens the generated PDF. The `.nojekyll` file disables the Jekyll build step.

This repository was originally based on [elipapa/markdown-cv](https://github.com/elipapa/markdown-cv) and remains available under the MIT License.
