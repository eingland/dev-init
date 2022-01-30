sudo apt update && sudo apt upgrade -y
sudo apt install zsh
curl 'https://raw.githubusercontent.com/eingland/dev-init/main/os/linux/config/.zshrc' > ~/.zshrc
chsh -s /usr/bin/zsh