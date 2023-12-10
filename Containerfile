FROM ghcr.io/ublue-os/silverblue-main:latest

RUN wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-$(rpm -E %fedora)/kylegospo-gnome-vrr-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo

RUN rnpm-ostree override replace \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr \
    rpm-ostree install -y \
        zsh \
        powerline-fonts \
        gnome-shell-extension-gsconnect \
        nautilus-gsconnect \
        goverlay \
        podman-docker \
        gnome-shell-extension-forge \
        gnome-shell-extension-appindicator