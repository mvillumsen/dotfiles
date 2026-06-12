# SSH and GPG Key Management

This guide covers SSH and GPG key setup, backup, encrypted storage, and restore.

## KEYID explained

`KEYID` is your GPG key identifier (usually the long key id shown by GPG).

Find it with:

```bash
gpg --list-secret-keys --keyid-format=long
```

Example output line:

```text
sec   ed25519/ABCD1234EFGH5678 2026-01-01 [SC]
```

In this example, `ABCD1234EFGH5678` is the KEYID.

## SSH key setup

### What is ed25519?

`ed25519` is a modern public-key algorithm for SSH keys. For most users it is the default recommended choice over RSA for new keys because it is fast, secure, and uses shorter keys.

### Recommended SSH key strategy

- Minimum: one dedicated personal key for source control.
- Better: one personal key and one work key (separate trust boundaries).
- Avoid using one shared key for everything long-term.

Suggested names:

- `~/.ssh/id_ed25519`
- `~/.ssh/id_ed25519_github_work`
Example config matching this setup:

```sshconfig
Host *
  AddKeysToAgent yes
  UseKeychain yes

Host github-private
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github_personal
  IdentitiesOnly yes

Host github-tv2
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github_work
  IdentitiesOnly yes
```

Then use remotes like:

- `git@github.com:OWNER/REPO.git` for private/default GitHub repos
- `git@github-tv2:tv2/REPO.git` for TV2 repos

### Git identity split by local path

Keep your default identity in `~/.gitconfig`, then override by folder path:

```ini
[include]
  path = ~/.gitconfig-private

[includeIf "gitdir:~/workspace/tv2/"]
  path = ~/.gitconfig-tv2
```

With this setup:

- private identity is the default everywhere
- repos under `~/workspace/tv2/` use the TV2 identity

### Migrating from one id_rsa key

1. Generate new ed25519 key(s).
2. Add the new public key(s) to GitHub/GitLab.
3. Update `~/.ssh/config` with your private default on `github.com` and `github-tv2` for TV2.
4. Test with `ssh -T git@github.com` and `ssh -T git@github-tv2`.
5. Rotate out old `id_rsa` once all repos authenticate with new key(s).

If you already have a key backup:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# Copy private/public key pair into ~/.ssh, for example id_ed25519 and id_ed25519.pub
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

Note: passphrases for SSH keys added this way are stored in Apple Keychain.
Open Keychain Access and search for `id_ed25519` to find the related entries.

Ensure SSH config includes keychain support:

```sshconfig
Host *
  AddKeysToAgent yes
  UseKeychain yes

Host github-private
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github_personal
  IdentitiesOnly yes

Host github-tv2
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github_work
  IdentitiesOnly yes
```

Test GitHub SSH access:

```bash
ssh -T git@github.com
ssh -T git@github-tv2
```

## GPG key setup

If you already have a key backup:

```bash
gpg --import <private-key-file.asc>
gpg --import <public-key-file.asc>
gpg --list-secret-keys --keyid-format=long
```

If you need to create a new key:

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
```

Setup reference:

- https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e

## Backup to iCloud (encrypted)

Use iCloud Drive for encrypted backups, not as the live location of active keys.

- Keep active SSH keys in `~/.ssh`.
- Keep active GPG keys in `~/.gnupg`.
- Use iCloud Passwords for passphrases and notes, not private key files.

### 1) Export to a temporary local folder

```bash
mkdir -p ~/key-backup-tmp

# SSH (adjust file names if needed)
cp ~/.ssh/id_ed25519 ~/key-backup-tmp/
cp ~/.ssh/id_ed25519.pub ~/key-backup-tmp/
cp ~/.ssh/id_ed25519_github_work{,.pub} ~/key-backup-tmp/
# GPG (replace KEYID)
gpg --armor --export-secret-keys <KEYID> > ~/key-backup-tmp/gpg-secret.asc
gpg --armor --export <KEYID> > ~/key-backup-tmp/gpg-public.asc
gpg --export-ownertrust > ~/key-backup-tmp/gpg-ownertrust.txt
```

### 2) Create encrypted archive

```bash
tar -C ~/key-backup-tmp -czf ~/key-backup.tar.gz .
gpg --symmetric --cipher-algo AES256 --output ~/key-backup.tar.gz.gpg ~/key-backup.tar.gz
```

### 3) Move encrypted file to iCloud Drive

```bash
mkdir -p ~/Library/Mobile\ Documents/com~apple~CloudDocs/SecureBackups/keys
mv ~/key-backup.tar.gz.gpg ~/Library/Mobile\ Documents/com~apple~CloudDocs/SecureBackups/keys/
```

### 4) Remove unencrypted temporary files

```bash
rm -rf ~/key-backup-tmp
rm -f ~/key-backup.tar.gz
```

## Restore on a new Mac

```bash
# 1) Copy encrypted file locally first
cp ~/Library/Mobile\ Documents/com~apple~CloudDocs/SecureBackups/keys/key-backup.tar.gz.gpg ~/

# 2) Decrypt and extract
gpg --output ~/key-backup.tar.gz --decrypt ~/key-backup.tar.gz.gpg
mkdir -p ~/key-restore-tmp
tar -C ~/key-restore-tmp -xzf ~/key-backup.tar.gz

# 3) Restore SSH keys
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cp ~/key-restore-tmp/id_ed25519{,.pub} ~/.ssh/
cp ~/key-restore-tmp/id_ed25519_github_work{,.pub} ~/.ssh/
chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_github_work
chmod 644 ~/.ssh/id_ed25519.pub ~/.ssh/id_ed25519_github_work.pub

# 4) Restore GPG keys and trust
gpg --import ~/key-restore-tmp/gpg-secret.asc
gpg --import ~/key-restore-tmp/gpg-public.asc
gpg --import-ownertrust ~/key-restore-tmp/gpg-ownertrust.txt

# 5) Cleanup
rm -rf ~/key-restore-tmp
rm -f ~/key-backup.tar.gz ~/key-backup.tar.gz.gpg
```

## Security checklist

- Enable FileVault.
- Enable iCloud Advanced Data Protection (if available).
- Keep one offline encrypted backup copy (for example USB).
