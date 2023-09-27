#!/bin/bash

# função para imprimir o menu
print_menu() {
    echo "Selecione o que deseja instalar:"
    echo "1. Google Chrome"
    echo "2. VMWarePlayer"
    echo "3. VSCode"
    echo "4. Microsoft Teams"
    echo "5. VLC"
    echo "6. Docker"
    echo "0. Sair"
}

# loop do menu
while true; do
    print_menu
    read -p "Opção: " opcao

    case $opcao in
        1)
            # instalação do Google Chrome
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
            sudo apt-get update
            sudo apt-get install google-chrome-stable
            ;;
        2)
            # instalação do VMWarePlayer
            sudo apt-get update
            sudo apt-get install -y build-essential linux-headers-$(uname -r)
            wget https://download3.vmware.com/software/player/file/VMware-Player-16.1.1-17801498.x86_64.bundle
            sudo sh VMware-Player-16.1.1-17801498.x86_64.bundle
            ;;
        3)
            # instalação do VSCode
            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
            sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
            sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
            sudo apt-get install apt-transport-https
            sudo apt-get update
            sudo apt-get install code
            ;;
        4)
            # instalação do VLC
            sudo apt-get update
            sudo apt-get install -y vlc
            ;;
        5)
            # instalação do Microsoft Teams
            sudo apt install curl -y
            curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/ms-teams.gpg > /dev/null
            echo 'deb [signed-by=/usr/share/keyrings/ms-teams.gpg] https://packages.microsoft.com/repos/ms-teams stable main' | sudo tee /etc/apt/sources.list.d/ms-teams.list
            sudo apt update -y
            sudo apt install teams -y
            ;;
        6)
            # instalação do Docker
            sudo apt-get update
            sudo apt-get install ca-certificates curl gnupg
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            echo \
            "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
            "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            ;;
        0)
            # sair do script
            exit
            ;;
        *)
            # opção inválida
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done
