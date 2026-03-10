# My Dotfiles
It's recommended first install package mangers to facilitate app installation

## Package Manager
- Homebrew
- Scoop
- apt

## Main apps
- Nushell
- Wezterm
- Vivid

## Installation
First install package manager and after Nusheall and Wezterm, with nushell it's
possible to create symlinks to move configurations to right folders. 

### Nushell
Erase default `config.nu` and `env.nu`, after create symlink from dvrc.

```shell
# Check if path exists
$"($nu.default-config-dir)/config.nu" | path exists
```

Renomear para backup
```shell
mv $"($nu.default-config-dir)/config.nu" $"($nu.default-config-dir)/config.nu.bkp"
```

Symlink
```shell
ln -s $"($nu.home-path)/dvlopment/repos/dvrc/nushell/config.nu" $"($nu.default-config-dir)/config.nu"
```

Reload configuration
```shell
source $nu.config-path
```

Remove symlink
```shell
rm $"($nu.default-config-dir)/config.nu"
```

Creating a function to create symlink and add in `<nushell-dir>/modules/symlink-mod.nu`
```shell
export def symlink [source: string, target: string] {
  if ($nu.os-info.name | str contains "windows") {
        ^powershell -Command $"New-Item -ItemType SymbolicLink -Path '($target)' -Target '($source)'"
    } else {
        ^ln -s $source $target
    }
}
```

## Utils
Check installed apps `Homebrew`

```shell
brew list
```

Check nushell config dir
```shell
$nu.default-config-dir
```

## WezTerm Shortcuts

Defined in `wezterm/wezterm.lua`. Default keybindings are disabled and a custom leader is used. Platform modifiers:
- `KALT` = `CMD` on macOS, `ALT` on Windows/Linux
- `KALTSHIFT` = `KALT+SHIFT`
- Leader = `KALT + w`

- Copy/Paste
  - `CTRL + X` → Activate copy mode
  - `CTRL + V` → Paste (PrimarySelection; duplicate mapping to Clipboard also present)
- Font Size
  - `CTRL + =` → Increase font size
  - `CTRL + -` → Decrease font size
  - `CTRL + 0` → Reset font size
- Tabs
  - `CTRL + SHIFT + t` → New tab
  - `CTRL + SHIFT + w` → Close current tab (confirm)
- Panes
  - `KALTSHIFT + '+'` → Split pane horizontally
  - `KALTSHIFT + '_'` → Split pane vertically
  - `KALTSHIFT + K` → Close current pane (confirm)
  - `KALT + z` → Toggle pane zoom
  - `KALT + Arrow` → Focus pane Left/Right/Up/Down
  - `Leader + Arrow` → Resize pane Left/Right/Up/Down by 1 cell
  - `CTRL + j` → Smart split/zoom helper:
    - If one pane: split down creating a 20% bottom pane
    - If multiple panes and first not zoomed: zoom first pane
    - If zoomed: unzoom and focus the second pane
- Reload
  - `Leader + r` → Reload configuration

## Tasks
- [ ] Install Package
- [ ] Install Nushell
- [ ] Install WezTerm
- [ ] Create Symlinks
- [ ] Change wezterm shortcuts to acept CMD and ALT

# REFERENCES

- https://mise.jdx.dev/getting-started.html
 
## Project Analysis

### Overview
- Purpose: Centralize cross‑platform dotfiles for a consistent dev environment across Windows, Linux, and macOS.
- Core tools: Nushell, WezTerm, Helix, PowerShell, VS Code, Starship, Yazi.
- Extras: Colima profile with Netskope cert provisioning, Docker Desktop reset script, language/tooling paths (Go, Elixir LS).

### Repository Structure
- Terminal: `wezterm/wezterm.lua`, `wezterm/envwez.lua`.
- Shells: `nushell/config.nu`, `nushell/env.nu` (Windows), `nushell/env.linux.nu` (Linux), `powershell/Microsoft.PowerShell_profile.ps1`.
- Editors: `helix/config.toml`, `helix/languages.toml`, `vscode/settings.json`, `micro/lsp.json`.
- Tools: `yazi/config/yazi.toml`, `starship/starship.toml`.
- Infra: `colima/netskope.yaml`, `homebrew/clean_cache.sh`.

### Configuration Highlights
- Nushell
  - Windows buffer/OSC133 workaround to prevent extra newlines (Windows Terminal + Nushell integration bugs).
  - Theming via `vivid` (tokyonight) and `hx` as default editor.
  - OS‑specific env files set editor, PATH, Go toolchain, Elixir LS, Yazi `file` path.
  - Linux config handles PATH conversion explicitly with `std path add` to avoid conversion traps.
- PowerShell
  - Custom prompt (OSC 7 support), `y` function to launch Yazi and cd back to selected dir, Starship initialized.
- WezTerm
  - Default keybindings disabled; custom leader (`CMD-w`), pane management, zoom, tabs, JetBrains Mono, tokyonight colors.
  - Windows default shell set to `nu`.
- Editors
  - Helix uses Solarized Light, ruler at 80, soft wrap, autosave on focus change; language servers/formatters for Python, Go, web.
  - VS Code configured similarly (Solarized Light, ruler at 79, no minimap, sidebar on the right).
- Yazi
  - Opener configured to use `%EDITOR%` on Windows.
- Colima (macOS)
  - `vz`/`aarch64` profile with sshfs mounts, optional k3s, and user provision step to install Netskope cert and restart Docker.

### Notable Findings
- WezTerm duplicate paste binding: `CTRL+V` mapped twice (Clipboard and PrimarySelection). Keep one or split across different keys.
- WezTerm comment mismatch: comment says "C‑S‑X" for ActivateCopyMode, binding is `CTRL+X` (no SHIFT).
- Nushell/WezTerm integration: `nushell/open-file.nu` passes `--pane-id ...$helix_pane`; the ellipsis is unnecessary/invalid. Should be `--pane-id ($helix_pane)`.
- Starship config file is empty (`starship/starship.toml`) while Starship is initialized in PowerShell; consider adding prompt modules/settings.
- Naming mismatch: `homebrew/clean_cache.sh` actually wipes Docker Desktop artifacts on macOS (a reset script). Consider renaming or adding a brew cache cleaner.
- Minor typos in README (e.g., "Nusheall", mixed English/Portuguese) if aiming for polished public docs.
- Task note mentions accepting CMD and ALT for WezTerm; current bindings are mostly CMD or CTRL only.

### Suggestions / Quick Fixes
- Fix `nushell/open-file.nu`:
  - Replace `--pane-id ...$helix_pane` with `--pane-id ($helix_pane)`.
- Resolve WezTerm keybindings:
  - Remove one of the `CTRL+V` bindings or assign PrimarySelection to another key.
  - Align comments with actual modifiers; add parallel ALT variants if desired.
  - Consider whether using `CMD-w` as leader conflicts with muscle memory for closing tabs/windows (defaults disabled, but choice may still surprise).
- Populate `starship/starship.toml` with a minimal prompt config to standardize across shells.
- Consolidate shared env (Go, Elixir LS, editor) into a reusable Nushell module and import from both `env.nu` and `env.linux.nu`.
- Rename `homebrew/clean_cache.sh` to something like `docker_desktop_reset.sh` (or add a separate brew cache cleanup script).

### Setup Notes
- Symlinking instructions in README are clear; consider adding the proposed `symlink` helper as a Nushell module (e.g., `<nushell-config-dir>/modules/symlink-mod.nu`) and referencing it in installation steps.
- Ensure `%EDITOR%`/`$env.EDITOR` is set consistently (Helix) so Yazi and other tools behave the same across OSes.

### Next Steps (if you want help)
- I can patch the Nushell open-file function and WezTerm bindings, add dual CMD/ALT shortcuts, and provide a baseline `starship.toml`. Let me know and I’ll apply the changes.
