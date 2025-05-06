# Install basic packages
sudo pacman -S git tree stow less zip unzip zsh firefox

# Configure git
git config --global user.email "teun.reyniers@hotmail.be"
git config --global user.name "teunreyniers"
git config --global init.defaultBranch main


# Terminal
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
