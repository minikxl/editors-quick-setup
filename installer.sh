#!/bin/bash

sudo apt update && sudo apt install -y wget tar unzip neovim

command -v wget >/dev/null 2>&1 || { echo >&2 "Wymagany jest 'wget', ale nie jest zainstalowany. Instalacja..."; sudo apt install wget -y; }
command -v tar >/dev/null 2>&1 || { echo >&2 "Wymagany jest 'tar', ale nie jest zainstalowany. Instalacja..."; sudo apt install tar -y; }


LF_VERSION="r31"
LF_URL="https://github.com/gokcehan/lf/releases/download/${LF_VERSION}/lf-linux-amd64.tar.gz"

# Pobieranie i instalacja lf
cd /tmp
wget $LF_URL
tar xvf lf-linux-amd64.tar.gz
chmod +x lf
sudo mv lf /usr/bin

# Konfiguracja lf i neovim
mkdir -p ~/.config/lf
mkdir -p ~/.config/nvim

curl -o ~/.config/lf/lfrc https://raw.githubusercontent.com/minikxl/editors-quick-setup/main/lfrc
curl -o ~/.config/lf/icons https://raw.githubusercontent.com/minikxl/editors-quick-setup/main/lf-icons
curl -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/minikxl/editors-quick-setup/main/nvimrc

# Wybór powłoki
echo "Wybierz powłokę:"
options=("Bash" "Zsh" "Fish")
select opt in "${options[@]}"; do
    case $opt in
        "Bash")
            shell_config=~/.bashrc
            break
            ;;
        "Zsh")
            shell_config=~/.zshrc
            break
            ;;
        "Fish")
            shell_config=~/.config/fish/config.fish
            break
            ;;
        *)
            echo "Niepoprawna opcja, wybieram Bash jako domyślną powłokę"
            shell_config=~/.bashrc
            break
            ;;
    esac
done

# Wybór edytora
echo "Wybierz edytor domyślny:"
options=("Neovim" "Vim" "Nano")
select opt in "${options[@]}"; do
    case $opt in
        "Neovim")
            editor=nvim
            break
            ;;
        "Vim")
            editor=vim
            break
            ;;
        "Nano")
            editor=nano
            break
            ;;
        *)
            echo "Niepoprawna opcja, wybieram Neovim jako domyślny edytor"
            editor=nvim
            break
            ;;
    esac
done

echo "source ~/.config/lf/icons" >> $shell_config
echo "export LF_ICONS" >> $shell_config
echo "export EDITOR=$editor" >> $shell_config
echo "export VISUAL=$editor" >> $shell_config