FROM ghcr.io/ublue-os/silverblue-main:latest


RUN wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-$(rpm -E %fedora)/kylegospo-gnome-vrr-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo

RUN ostree remote add vscode https://packages.microsoft.com/keys/microsoft.asc

COPY etc/yum.repos.d/vscode.repo /etc/yum.repos.d/vscode.repo

RUN rpm-ostree override remove \
        ublue-os-update-services \
        firefox \
        firefox-langpacks

RUN rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr \
        mutter \
        mutter-common \
        gnome-control-center \
        gnome-control-center-filesystem

RUN rpm-ostree install \
        zsh \
        eza \
        powerline-fonts \
        goverlay \
        podman-docker \
        podman-compose \
        ripgrep \
        gnome-shell-extension-forge \
        gnome-shell-extension-appindicator \
        nextcloud-client \
        pam_yubico \
        yubikey-personalization-gui 

RUN rpm-ostree install \
        keepassxc \
        neovim 

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
        grim \
        restic \
        swappy

COPY etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

COPY etc/systemd/system/firstboot.service /etc/systemd/system/firstboot.service

RUN chmod 644 /etc/systemd/system/firstboot.service

RUN systemctl enable firstboot.service

COPY var/opt/post-install.sh /var/opt/post-install.sh
