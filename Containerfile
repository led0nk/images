ARG BASE_IMAGE="quay.io/fedora/fedora-silverblue"
ARG FEDORA_VERSION

FROM $BASE_IMAGE:$FEDORA_VERSION

RUN rpm-ostree override remove \
        firefox \
        firefox-langpacks 

RUN rpm-ostree install \
        gnome-terminal \
        zsh \
        eza \
        powerline-fonts \
        podman-docker \
        podman-compose \
        ripgrep \
        htop \
        fzf \
        fd-find \
        tmux \
        neovim 

RUN rpm-ostree install \
        goverlay \
        nextcloud-client \
        pam_yubico \
        keepassxc \
        yubikey-personalization-gui 

RUN rpm-ostree install \
        libusb1-devel 

RUN rpm-ostree install  \      
        sway \
        swaybg \
        wlogout \
        wdisplays \
        swaylock \
        swayidle \
        axel \
        waybar \
        greetd \
        gtkgreet \
        rofi \
        ulauncher \
        NetworkManager-tui \
        network-manager-applet \
        blueman \
        bluez \
        bluez-tools \
        linux-firmware \
        pavucontrol \
        brightnessctl \
        pamixer \
        swappy \
        dunst \
        grim \
        imv \
        SwayNotificationCenter \
        tailscale \
        trayscale

RUN rpm-ostree install \
        restic \
        ShellCheck \
        unrar \
        unrar-free 

#RUN ln -s /usr/bin/ld.bfd /usr/bin/ld

COPY etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

ARG XDG_RUNTIME_DIR="/run/user/1001"

RUN mkdir -p /var/run && \
    ln -s ${XDG_RUNTIME_DIR}/podman/podman.sock /var/run/docker.sock
