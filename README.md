# Fedora Silverblue – Custom Immutable Image 

**led0nk / images** is an OCI-native Fedora Silverblue build that bakes my
daily-driver tooling straight into the operating system, giving me a reproducible,
fully-immutable workstation I can rebase onto any machine in minutes.

---

## Highlights

* **Immutable base** – starts from `quay.io/fedora/fedora-silverblue` and
  produces an OSTree commit.
* **Container transport** – published to
  `ghcr.io/led0nk/images`, consumable with `rpm-ostree rebase`.
* **Declarative package set** – extra RPMs are layered in at build time with
  `dnf` (previously `rpm-ostree install`).
* **Signed supply-chain** – each build is signed with cosign; verify before you
  boot.
* **CI/CD** – GitHub Actions builds, pushes and signs every tag.

---

## What’s inside ?

| Category | Notable packages¹ |
| -------- | ----------------- |
| CLI / Dev | `ripgrep`, `fzf`, `bat`, `fd-find`, `tmux`, `helm`, `python3-pip`, `nmap`, `ShellCheck`, `restic` |
| Desktop (GNOME) | `gnome-terminal`, `nextcloud-client`, `keepassxc` |
| Wayland / Sway | `sway`, `swaybg`, `swaylock`, `swayidle`, `waybar`, `wlogout`, `rofi`, `blueman`, `pavucontrol`, `grim`, `swappy`, `dunst`, `imv` |
| Networking | `tailscale`, `podman-docker`, `podman-compose`, `NetworkManager-tui` |
| Security | `pam_yubico`, `yubikey-personalization-gui`, `age` |

> ¹ See the full list in [`Containerfile`](./Containerfile). :contentReference[oaicite:0]{index=0}

---

## Quick start

On an existing Fedora Silverblue/Kinoite system:
```bash
sudo rpm-ostree rebase --experimental \
  ostree-unverified-registry:ghcr.io/led0nk/images:latest
```
reboot and enjoy

### Image-Verification:
```bash
cosign verify --key cosign.pub ghcr.io/led0nk/images:latest
```
