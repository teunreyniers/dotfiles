# Install basic packages
sudo pacman -S --no-confirm git tree stow less zip unzip zsh firefox tff-jetbrains-mono ttf-jetbrains-mono-nerd jq
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim

# Configure git
set_git_username() {
    current_username=$(git config --global user.name)
    if [ -z "$current_username" ]; then
        read -p "Enter your Git username: " username
        git config --global user.name "$username"
        echo "Git username set to: $username"
    else
        echo "Git username is already set to: $current_username"
    fi
}

set_git_email() {
    current_email=$(git config --global user.email)
    if [ -z "$current_email" ]; then
        read -p "Enter your Git email: " email
        git config --global user.email "$email"
        echo "Git email set to: $email"
    else
        echo "Git email is already set to: $current_email"
    fi
}

# Main script execution
set_git_username
set_git_email
git config --global init.defaultBranch main


# Terminal
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

