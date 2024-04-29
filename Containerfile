ARG BASE_IMAGE="quay.io/fedora/fedora-silverblue"
ARG FEDORA_VERSION="40"

FROM $BASE_IMAGE:$FEDORA_VERSION

COPY etc/yum.repos.d/SwayNotificationCenter.repo /etc/yum.repos.d/SwayNotificationCenter.repo

RUN rpm-ostree override remove \
        firefox \
        firefox-langpacks

RUN rpm-ostree install \
        zsh \
        eza \
        powerline-fonts \
        podman-docker \
        podman-compose \
        ripgrep \
        neovim  

RUN rpm-ostree install \
        goverlay \
        nextcloud-client \
        pam_yubico \
        keepassxc \
        yubikey-personalization-gui 

RUN rpm-ostree install  \      
        sway \
        wlogout \
        swaylock \
        axel \
        waybar \
        greetd \
        gtkgreet \
        rofi \
        NetworkManager-tui \
        network-manager-applet \
        blueman \
        pavucontrol \
        pamixer \
        swappy \
        SwayNotificationCenter \
        grim 

RUN rpm-ostree install \
        restic \
        ShellCheck

COPY etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

ARG XDG_RUNTIME_DIR="/run/user/1001"

RUN mkdir -p /var/run && \
    ln -s ${XDG_RUNTIME_DIR}/podman/podman.sock /var/run/docker.sock

#COPY etc/profile.d/post-install.sh /etc/profile.d/post-install.sh
