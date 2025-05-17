# /bin/bash
# Install basic packages
sudo pacman -S --noconfirm --needed git tree stow less zip unzip zsh firefox ttf-jetbrains-mono ttf-jetbrains-mono-nerd jq waybar base-devel rofi-wayland alacritty zoxide polkit hyprpolkitagent hyprpaper archlinux-xdg-menu dolphin swayimg
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim

# Configure git
current_username=$(git config --global user.name)
if [ -z "$current_username" ]; then
    read -p "Enter your Git username: " username
    git config --global user.name "$username"
fi
current_email=$(git config --global user.email)
if [ -z "$current_email" ]; then
    read -p "Enter your Git email: " email
    git config --global user.email "$email"
fi
git config --global init.defaultBranch main


# Terminal
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.config/alacritty/themes" ]; then
    mkdir -p $HOME/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/themes
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode" ]; then
    mkdir -p $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode
    git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode
fi

# AUR - yay
if ! command -v yay &> /dev/null; then
    mkdir $HOME/git
    git clone https://aur.archlinux.org/yay.git $HOME/git/yay
    cd $HOME/git/yay
    makepkg -si
fi

# Bluetooth
if sudo mesg | grep -i bluetooth > /dev/null; then
    sudo pacman -S --noconfirm --needed bluez bluez-utils
    sudo systemctl start bluetooth.service
    sudo systemctl enable bluetooth.service
    yay -S --noconfirm rofi-bluetooth-git
fi

# Audio
sudo pacman -S --noconfirm --needed helvum

