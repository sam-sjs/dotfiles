# dotfiles

## Layout

| Path | What |
|---|---|
| `.zshrc` | Shared zsh config, sourced by both platform files below |
| `macos/` | macOS-only: zsh, Hammerspoon window manager, Karabiner, Alfred themes |
| `linux/` | Linux-only: zsh, AwesomeWM, rofi, kmonad, X/touchpad config |
| `ghostty/` | Terminal |
| `herdr/` | Terminal workspace manager |
| `hunk/` | Terminal diff viewer |
| `nvim/` | Neovim, lazy.nvim-managed |
| `omz/` | oh-my-zsh custom prompt theme |
| `zen/` | Zen Browser: prefs, keybindings, userChrome CSS |
| `surfingkeys.js` | Vim-style browser keybindings |

## Symlinks

### Shared

```sh
ln -s ~/dotfiles/nvim  ~/.config/nvim
ln -s ~/dotfiles/omz/lukerandall-custom.zsh-theme ~/.oh-my-zsh/themes/lukerandall-custom.zsh-theme
```

### macOS

```sh
ln -s ~/dotfiles/macos/.zshrc       ~/.zshrc
ln -s ~/dotfiles/macos/.hammerspoon ~/.hammerspoon
ln -s ~/dotfiles/macos/karabiner    ~/.config/karabiner
ln -s ~/dotfiles/ghostty            ~/.config/ghostty
ln -s ~/dotfiles/hunk               ~/.config/hunk

# herdr: link the file, not the directory - the dir holds live sockets and logs
mkdir -p ~/.config/herdr
ln -s ~/dotfiles/herdr/config.toml ~/.config/herdr/config.toml
```

### Linux

```sh
ln -s ~/dotfiles/linux/.zshrc  ~/.zshrc
ln -s ~/dotfiles/linux/.xinitrc ~/.xinitrc
ln -s ~/dotfiles/linux/awesome ~/.config/awesome
ln -s ~/dotfiles/linux/config.rasi ~/.config/rofi/config.rasi
```

### Zen Browser

Find the profile via `about:support` → *Open Profile Folder*, then:

```sh
ZP="$HOME/Library/Application Support/zen/Profiles/<profile>"
ln -s ~/dotfiles/zen/chrome                     "$ZP/chrome"
ln -s ~/dotfiles/zen/user.js                    "$ZP/user.js"
ln -s ~/dotfiles/zen/zen-keyboard-shortcuts.json "$ZP/zen-keyboard-shortcuts.json"
```

## Machine-local settings

Anything machine-specific or private — hostnames, credentials, work config — goes in
`~/.zshrc.local`, which is **not tracked**. The shared `.zshrc` sources it if present:

```zsh
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
```
