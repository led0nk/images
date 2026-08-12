ARG BASE_IMAGE="quay.io/fedora/fedora-silverblue"
ARG FEDORA_VERSION

FROM $BASE_IMAGE:$FEDORA_VERSION

#RUN rpm-ostree override remove \
#        firefox \
#        firefox-langpacks 

RUN dnf install -y \
        gnome-terminal \
        zsh \
        eza \
        powerline-fonts \
        podman-docker \
        podman-compose \
        ripgrep \
        htop \
        fzf \
        bat \
        fd-find \
        tmux \
        helm \
        python3-pip \
        nmap \
        neovim \
        pprof

RUN dnf install -y \
        goverlay \
        nextcloud-client \
        pam_yubico \
        pam-u2f \
        yubikey-manager \
        keepassxc \
        yubikey-personalization-gui

RUN dnf install -y \
        libusb1-devel 

RUN dnf install -y \
        sway \
        swaybg \
        kanshi \
        wlogout \
        wdisplays \
        swaylock \
        swayidle \
        axel \
        waybar \
        rofi \
        NetworkManager-tui \
        network-manager-applet \
        blueman \
        bluez \
        bluez-tools \
        pavucontrol \
        brightnessctl \
        pamixer \
        swappy \
        dunst \
        grim \
        slurp \
        grimshot \
        tldr \
        imv \
        yq

# Enabled image-wide so a fresh user gets dock/undock handling without setup.
RUN systemctl --global enable kanshi.service

RUN dnf install -y \
        tailscale \
        age \
        fuse-sshfs \
        restic \
        ShellCheck \
        wireshark \
        openssl \
        unrar \
        unrar-free \
        yamllint \
        git-lfs \
        gh \
        lxpolkit.x86_64 \
        rclone

RUN systemctl enable tailscaled

RUN dnf install -y \
        powertop \
        lm_sensors \
        smartmontools \
        libinput-utils \
        lshw \
        v4l-utils \
        wf-recorder \
        gammastep

#RUN ln -s /usr/bin/ld.bfd /usr/bin/ld

COPY etc/pki/rpm-gpg/RPM-GPG-KEY-bitwarden /etc/pki/rpm-gpg/RPM-GPG-KEY-bitwarden
COPY etc/yum.repos.d/bitwarden.repo /etc/yum.repos.d/bitwarden.repo
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-bitwarden

# Bitwarden installs into /opt, which on ostree is a symlink to /var/opt and gets
# dropped at commit time, so relocate it into /usr/lib and repoint the launcher.
RUN mkdir -p /var/opt/Bitwarden && \
    dnf install -y bitwarden && \
    mv /var/opt/Bitwarden /usr/lib/bitwarden && \
    sed -i 's|/opt/Bitwarden/bitwarden|/usr/lib/bitwarden/bitwarden|' /usr/share/applications/bitwarden.desktop && \
    ln -sf /usr/lib/bitwarden/bitwarden /usr/bin/bitwarden

COPY etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

COPY etc/udev/rules.d/99-battery-charge-threshold.rules /etc/udev/rules.d/99-battery-charge-threshold.rules

# podman-docker already ships the docker.sock symlink (tmpfiles.d, %t-relative)
# and DOCKER_HOST via profile.d, so no manual symlink is needed here.
RUN systemctl --global enable podman.socket

RUN bootc container lint
