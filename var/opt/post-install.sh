#!/usr/bin/bash


#set repository-path
#export PATH=~/git/repo/
PATH=$PATH:~/git/repo/dotfiles
REPO_PATH=$REPO_PATH:~/git/repo


#create directories
mkdir -p $REPO_PATH/{dotfiles,minecraft,images}
mkdir -p $HOME/.config/{sway,waybar}


#clone git repositories
git clone https://github.com/led0nk/dotfiles.git $REPO_PATH/dotfiles
git clone https://github.com/led0nk/minecraft.git $REPO_PATH/minecraft
git clone https://github.com/led0nk/images.git $REPO_PATH/repo/images


#create systemlinks for dotfiles
ln -s $PATH/zsh/.zshrc $HOME/.zshrc
ln -s $PATH/zsh/.zshenv $HOME/.zshenv
ln -s $PATH/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -s $PATH/gitconfig/.gitconfig $HOME/.gitconfig
ln -s $PATH/.config/sway/config $HOME/.config/sway/config
ln -s $PATH/.config/waybar/config.jsonc $HOME/.config/waybar/config.jsonc
ln -s $PATH/.config/waybar/style.css $HOME/.config/waybar/style.css

#copy themefiles for rofi
cp -r $PATH/.config/themes $HOME/.config/rofi/


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