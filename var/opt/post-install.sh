#!/usr/bin/bash

#set repository-path
#export PATH=~/git/repo/
export HELP_PATH=/var/home/$USER/git/repo/dotfiles
export REPO_PATH=/var/home/$USER/git/repo

#create directories
mkdir -p $REPO_PATH/{dotfiles,minecraft,images}
mkdir -p $HOME/.config/{sway,waybar,hypr,rofi,wofi}
mkdir -p $HOME/Pictures/Wallpaper/

#clone git repositories
git clone https://github.com/led0nk/dotfiles.git $REPO_PATH/dotfiles
git clone https://github.com/led0nk/minecraft.git $REPO_PATH/minecraft
git clone https://github.com/led0nk/images.git $REPO_PATH/repo/images

#create systemlinks for dotfiles
ln -s $HELP_PATH/zsh/.zshrc $HOME/.zshrc
ln -s $HELP_PATH/zsh/.zshenv $HOME/.zshenv
ln -s $HELP_PATH/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -s $HELP_PATH/gitconfig/.gitconfig $HOME/.gitconfig
ln -s $HELP_PATH/.config/sway/config $HOME/.config/sway/config
ln -s $HELP_PATH/.config/waybar/config.jsonc $HOME/.config/waybar/config.jsonc
ln -s $HELP_PATH/.config/waybar/style.css $HOME/.config/waybar/style.css
ln -s $HELP_PATH/.config/hypr/hyprland.conf $HOME/.config/hypr/hyprland.conf
ln -s $HELP_PATH/.config/wofi/style.css $HOME/.config/wofi/style.css

#copy themefiles for rofi and background
cp -r $HELP_PATH/.config/themes $HOME/.config/rofi/
cp -r $HELP_PATH/background.png $HOME/Pictures/Wallpaper/background.png

#link golang variable
echo export PATH=$HELP_PATH:/usr/lib/golang/bin >$HOME/.profile

#install zplug + extensions + change shell to zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /usr/bin/zsh
zsh
zplug install

#remove files necessary for post-install-script
sudo rm -rf /var/opt/dotfiles
sudo rm -f /etc/systemd/system/firstboot.service

#generating ssh-key with github alias-mail
ssh-keygen -t ed25519 -C "10290002+led0nk@users.noreply.github.com"
