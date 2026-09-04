# Daniel Montero Cervantes - Resume

The resume is maintained in Markdown and rendered directly to PDF with Pandoc and the Tectonic LaTeX engine.

## Install dependencies

The build requires [Pandoc](https://pandoc.org/) and [Tectonic](https://tectonic-typesetting.github.io/). Run the installer for your platform once.

macOS with Homebrew:

```sh
./scripts/install-macos-dependencies.sh
```

Arch Linux with pacman:

```sh
./scripts/install-linux-dependencies.sh
```

Windows with Chocolatey, from PowerShell:

```powershell
.\scripts\install-windows-dependencies.ps1
```

## Build

The build is the same on every platform. From a POSIX shell, including Git Bash on Windows:

```sh
./scripts/build.sh
```

The script converts the repository's `resume.md` to `resume.pdf` and sets reproducible-build timestamps, so rebuilding unchanged content produces the same PDF.

## Build directly

From the repository root:

```sh
pandoc --defaults pandoc.yaml
```

The command reads `resume.md` and creates `resume.pdf`. Layout and typography are defined in `template.tex`.

GitHub Pages serves the static `index.html`, which opens the generated PDF. The `.nojekyll` file disables the Jekyll build step.
