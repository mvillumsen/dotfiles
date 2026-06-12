Dotfiles
========

Personal dotfiles for macOS, bootstrapped with Dotbot.

## Fresh Mac Setup

### 1) Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2) Setup or restore SSH key (for GitHub)

If you already have a key backup:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# Copy your private/public key pair into ~/.ssh, for example id_ed25519 and id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

If you need to create a new key:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Add key to the agent and macOS keychain:

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Ensure SSH config includes keychain support:

```sshconfig
Host *
	AddKeysToAgent yes
	UseKeychain yes
```

Test GitHub SSH access:

```bash
ssh -T git@github.com
```

### 3) Clone this repo

```bash
git clone git@github.com:mvillumsen/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 4) Install packages from Brewfile

```bash
brew bundle
```

This installs the current baseline, including Ghostty, zsh, fzf, Starship, and VS Code extensions listed in [Brewfile](Brewfile).

### 5) Apply dotfiles (symlinks)

```bash
./install
```

### 6) (Optional) Set Homebrew zsh as default shell

```bash
chsh -s "$(brew --prefix)/bin/zsh"
```

Open a new terminal session after this.

### 7) Setup or restore GPG key (for signed commits)

Use the dedicated key guide for GPG setup, backup, restore, and iCloud storage:

- [docs/keys.md](docs/keys.md)
- [docs/new-mac-checklist.md](docs/new-mac-checklist.md)

## What This Repo Uses

- Shell: zsh + [Starship](https://starship.rs/) + zsh-completions + zsh-autosuggestions + zsh-syntax-highlighting (no Prezto)
- Fuzzy finder: fzf via [fzf.zsh](fzf.zsh)
- Terminal: [Ghostty](https://ghostty.org/)
- Git config: [git/gitconfig](git/gitconfig)
- Vim config: [vim/vimrc](vim/vimrc)

## Notes

- VS Code settings are synced through GitHub account sync.
- If you change prompt behavior, prefer updating Starship instead of adding another prompt framework.
- Run `:PlugInstall` in Vim once after first setup (if you want the configured Vim plugins).
- If zsh shows an `insecure directories` warning when loading completions, run:

```bash
chmod -R go-w "$(brew --prefix)/share/zsh"
compaudit | xargs chmod g-w
rm -f ~/.zcompdump
exec zsh
```

## Key Management

For SSH and GPG key management, backups, and restore steps, see:

- [docs/keys.md](docs/keys.md)

## New Mac Verification

For a detailed post-setup checklist (including non-iCloud folders and security checks), see:

- [docs/new-mac-checklist.md](docs/new-mac-checklist.md)
