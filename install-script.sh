#!/bin/sh 

set -e pipefail 
Os="$(uname -s)"

if [ ! "$Os" = "Linux" ]; then 
	printf "\n"
	printf "  ================================================\n"
	printf "         Script uniquement compatible Linux       \n"
	printf "  ================================================\n"
	exit 1
fi

if ! which node > /dev/null; then
		printf "\n"
		printf "  ================================================\n"
		printf "      Vous devez installer NodeJs en premier      \n"
		printf "  ================================================\n"
		exit 1
fi

printf "\n"
printf "  =============================================\n"
printf "       Script d'installation Web dev Ubuntu    \n"
printf "                 by Moumax (v1.00)             \n"
printf "  =============================================\n"
printf "\n"
printf "\n"
printf "  ----------------DEPENDANCES------------------\n"
printf "\n"
printf "  | dep -- Installations de dépendances       |\n"
printf "\n"
printf "  ----------------ENVIRONNEMENT----------------\n"
printf "\n"
printf "  | update -- Update et Upgrade du système    |\n"
printf "  | folders -- Création de l'archi dossier    |\n"
printf "  | git -- Installation de l'env git          |\n"
printf "  | folders -- Création de l'archi dossier    |\n"
printf "  | git -- Installation de l'env git          |\n"
printf "  | rust -- Installation de rust & cargo      |\n"
printf "  | node -- Installation de NVM pour node     |\n"
printf "\n"
printf "  --------------------OUTILS-------------------\n"
printf "\n"
printf "  | gitui -- Installation de gitui            |\n"
printf "  | font -- Installation de la font hack      |\n"
printf "  | alacritty -- Installation de Alacritty    |\n"
printf "  | starship -- Installation de Starship      |\n"
printf "  | fzf -- Installation de fzf                |\n"
printf "  | btop -- Installation de btop              |\n"
printf "\n"
printf "  ---------------------------------------------\n"
printf "  | q -- Quitter le script                    |\n"
printf "\n"
printf "  ---------------------------------------------\n"

read -p "Votre choix ? " choice

if [ "$choice" = "update" ]; then
	cd ~
	sudo apt upgrade
	sudo apt update
	printf "  =========================================\n"
	printf "            Fin de la mise à jour          \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "folders" ]; then
	mkdir -p ~/dev &&\
	mkdir -p ~/apps &&\
	mkdir -p ~/downloads &&\
	sudo rm -rf ~/Bureau ~/Images ~/Musique ~/Vidéos ~/Documents ~/Modèles ~/Public ~/Téléchargements
	printf "  =========================================\n"
	printf "          Les dossiers ont été crées       \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "font" ]; then
	wget -P ~/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip && \
	cd ~/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv ~/downloads/Hack.zip . && \
	unzip Hack.zip
	printf "  =========================================\n"
	printf "       Fin de l'installation de la font    \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "alacritty" ]; then
	sudo apt update && sudo apt upgrade
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install alacritty
	mkdir -p ~/.config/alacritty
	stow -t ~/.config/alacritty alacritty
	printf "  =========================================\n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "starship" ]; then
	cd ~/ && \
	curl -sS https://starship.rs/install.sh | sh
	mkdir -p ~/.config/starship
	cd ~/dev/dotfiles && \
	stow -t ~/.config/starship starship
	printf "  =========================================\n"
	printf "      Fin de l'installation de starship    \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "fzf" ]; then
	cd ~/ && \
	git clone https://github.com/junegunn/fzf ~/.fzf && \
	cd ~/.fzf && ./install
	printf "  =========================================\n"
	printf "         Fin de l'installation de fzf      \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "btop" ]; then
	wget -P ~/downloads https://github.com/aristocratos/btop/releases/download/v1.2.13/btop-x86_64-linux-musl.tbz && \
	cd ~/apps && \
	mkdir -p btop && \
	mv ~/downloads/btop-x86_64-linux-musl.tbz ~/apps/btop && \
	cd btop
	tar -xjf btop-x86_64-linux-musl.tbz && \
	rm btop-x86_64-linux-musl.tbz && \
	cd btop && sudo make install
	printf "  =========================================\n"
	printf "         Fin de l'installation de btop     \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "rust" ]; then
	cd ~ && \
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	printf "  =========================================\n"
	printf "         Fin de l'installation de rust     \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "            REDEMARREZ LE TERMINAL         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "gitui" ]; then
	cd ~ && \
	cargo install gitui
	mkdir ~/.config/gitui && \
	cd ~/dev/dotfiles
	stow -t ~/.config/gitui gitui
	printf "  =========================================\n"
	printf "        Fin de l'installation de gitui     \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "git" ]; then
	read -p "Ton email ? : " EmailGit

	if [ "$EmailGit" = "" ]; then
		printf "\n"
		printf "Tu dois rentrer un email valide\n"
		continue
	fi
	
	cd ~/.ssh 
	ssh-keygen -t ed25519 -C "$EmailGit"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_25519.pub
	printf "  =========================================\n"
	printf "     Fin de l'installation de l'auth git   \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "glow" ]; then
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation de glow      \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "node" ]; then
	cd ~ && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install 18 && \
	nvm install 16 && \
	nvm use 18
	printf "  =========================================\n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "  =========================================\n"
fi


if [ "$choice" = "dep" ]; then
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install -y git zsh zsh-syntax-highlighting curl i3 rofi compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget && \
	sudo apt autoremove -y && \
	sudo apt autoclean -y
	printf "  =========================================\n"
	printf "    Fin de l'installation des dependances  \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi
