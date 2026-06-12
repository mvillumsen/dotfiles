# New Mac Verification Checklist

Use this after initial setup to confirm your new Mac is complete, secure, and ready for daily work.

## 1) Identity and Security

What this covers:

- Your Apple account and recovery posture.
- Device-level protection (disk encryption, account access).
- Access continuity if your phone/laptop is lost.

Checks:

- [ ] Apple ID login complete and trusted devices list is correct.
- [ ] iCloud settings reviewed (including Keychain and Advanced Data Protection state).
- [ ] FileVault enabled (`System Settings -> Privacy & Security -> FileVault`).
- [ ] Touch ID configured for unlock/sudo (if used).
- [ ] Password manager is signed in and fully synced.
- [ ] 2FA recovery path verified (backup codes, recovery key, backup phone).

## 2) iCloud Sync Reality Check

What this covers:

- Verifying sync completion, not just initial sign-in.
- Confirming high-value data is actually present and accessible.

Checks:

- [ ] Desktop and Documents sync preference confirmed.
- [ ] Photos, Notes, Contacts, Calendars, Reminders, Safari, and Keychain synced.
- [ ] A few large/important files are opened from Finder to confirm content is downloaded.

## 3) Commonly Missed Local Folders

What this covers:

- Folders that are often local-only and not fully restored by iCloud.

Checks:

- [ ] `~/.ssh` restored (private keys, public keys, config, known_hosts).
- [ ] `~/.gnupg` restored (secret keys, trustdb, gpg-agent config).
- [ ] `~/.aws` restored (credentials/config if applicable).
- [ ] `~/.config` reviewed for tool settings you rely on.
- [ ] `~/workspace` (or other local project roots) present and correct.
- [ ] `~/Library/Application Support` spot-checked for critical local app data.
- [ ] `~/Library/Fonts` restored if you use custom fonts.

## 4) Dotfiles and Tool Bootstrap

What this covers:

- Rebuilding machine configuration from source-of-truth files.

Checks:

- [ ] Dotfiles repo cloned.
- [ ] `brew bundle` completed successfully.
- [ ] `./install` run to apply symlinks.
- [ ] Shell starts cleanly with expected prompt and aliases.

References:

- [README.md](../README.md)
- [docs/keys.md](./keys.md)

## 5) Git, SSH, and GPG Validation

What this covers:

- Auth and signing paths for source control.

Checks:

- [ ] SSH auth works: `ssh -T git@github.com`.
- [ ] Work alias works (if used): `ssh -T git@github-tv2`.
- [ ] Git identity split is correct (private default, TV2 override).
- [ ] GPG secret key present: `gpg --list-secret-keys --keyid-format=long`.
- [ ] Signed commit test works in a throwaway repo.
- [ ] `pinentry-mac` prompt appears when passphrase is needed.

## 6) Terminal and Shell UX

What this covers:

- Daily command-line ergonomics and quality-of-life features.

Checks:

- [ ] zsh is default shell (if intended).
- [ ] Starship prompt loads correctly.
- [ ] fzf integration works.
- [ ] autosuggestions and syntax highlighting are active.
- [ ] directory colors show in `ls` output.
- [ ] no `insecure directories` completion warning at startup.

If completion warnings appear:

```bash
chmod -R go-w "$(brew --prefix)/share/zsh"
compaudit | xargs chmod g-w
rm -f ~/.zcompdump
exec zsh
```

## 7) Language Toolchains and CLIs

What this covers:

- Runtime and CLI availability for your actual workflow.

Checks:

- [ ] Python, Node, Go, Java versions match expectations.
- [ ] `gh` authenticated and usable.
- [ ] `aws` authenticated (if used).
- [ ] Kubernetes CLIs (`kubectl`, `kubectx`) work (if used).
- [ ] VPN, certificates, and company proxies are configured (if required).

## 8) GUI Apps and Licenses

What this covers:

- Non-code tools and app state that often need manual attention.

Checks:

- [ ] Critical apps installed and launching (Ghostty, VS Code, Rectangle, Spotify, etc.).
- [ ] License/activation completed for paid apps.
- [ ] Browser profiles/extensions synced and expected.
- [ ] Any app-specific local libraries or databases restored.

## 9) Backup and Recovery Readiness

What this covers:

- Ensuring the new machine is safely recoverable.

Checks:

- [ ] Time Machine enabled and first backup completed.
- [ ] Encrypted SSH/GPG backup refreshed after verification.
- [ ] Recovery instructions and key locations documented where you keep ops notes.
- [ ] One offline backup copy available (for example encrypted USB archive).

## 10) Final Confidence Pass

What this covers:

- A quick end-to-end sanity test of your normal workday.

Checks:

- [ ] Open terminal, clone a repo, run tests/build.
- [ ] Open VS Code, verify extensions and sign-in.
- [ ] Perform one signed git commit.
- [ ] Reboot once and confirm everything still loads cleanly.
