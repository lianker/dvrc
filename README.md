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

## Utils
Check installed apps `Homebrew`

```shell
brew list
```

Check nushell config dir
```shell
$nu.default-config-dir
````

## Tasks

- [ ] Install Package
- [ ] Install Nushell
- [ ] Install WezTerm
- [ ] Create Symlinks

REFERENCES

- https://mise.jdx.dev/getting-started.html
