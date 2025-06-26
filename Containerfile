ARG BASE_IMAGE="quay.io/fedora/fedora-silverblue"
ARG FEDORA_VERSION

FROM $BASE_IMAGE:$FEDORA_VERSION

#RUN rpm-ostree override remove \
#        firefox \
#        firefox-langpacks 

RUN dnf install -y \
        gnome-terminal \
        zsh \
       # eza \
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
        keepassxc \
        yubikey-personalization-gui 

RUN dnf install -y \
        libusb1-devel 

RUN dnf install -y \      
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
        NetworkManager-tui \
        network-manager-applet \
        blueman \
        bluez \
        bluez-tools \
        linux-firmware \
        realtek-firmware \
        pavucontrol \
        brightnessctl \
        pamixer \
        swappy \
        dunst \
        grim \
        tldr \
        imv \
        yq

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
        git-lfs

#RUN ln -s /usr/bin/ld.bfd /usr/bin/ld

COPY etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

ARG XDG_RUNTIME_DIR="/run/user/1001"

RUN mkdir -p /var/run && \
    ln -s ${XDG_RUNTIME_DIR}/podman/podman.sock /var/run/docker.sock
