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

curl -o ~/.config/lf/lfrc https://github.com/minikxl/editors-quick-setup/main/lfrc
curl -o ~/.config/nvim/init.vim https://github.com/minikxl/editors-quick-setup/main/nvimrc
