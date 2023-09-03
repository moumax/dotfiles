#!/bin/sh 

set -e pipefail 
Os="$(uname -s)"

dialog_width=600
dialog_height=200

CRS='\033[0m'
CR='\033[0;31m'
CN='\033[0;30m'
CV='\033[0;32m'
CJ='\033[0;33m'
CB='\033[0;34m'
CVIO='\033[0;35m'
CC='\033[0;36m'
CBLA='\033[0;37m'

if [ ! "$Os" = "Linux" ]; then 
	printf "\n"
	printf "  ================================================\n"
	printf "         Script uniquement compatible Linux       \n"
	printf "  ================================================\n"
	exit 1
fi

while true; do

	printf "\n"
	printf "  =============================================\n"
	printf "    $CR Script d'installation Web dev Ubuntu   \n"
	printf "             by Moumax (v1.00) $CRS            \n"
	printf "  =============================================\n"
	printf "\n"
	printf "\n"
	printf "  $CB git $CRS     -- Install de l'env git \n"
	printf "  $CB dotfolders $CRS -- Archi des dossiers    \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all -- $CRS Tout installer             \n"
	printf "  $CR q -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# DEP
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
	printf "  =========================================\n"
	printf "         installation des dependances  \n"
	printf "         installation des dependances  \n"
	printf "         installation des dependances  \n"
	printf "         installation des dependances  \n"
	printf "  =========================================\n"
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install -y git curl compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget vim zsh && \
	sudo apt autoremove -y && \
	sudo apt autoclean -y
	printf "  =========================================\n"
	printf "    Fin de l'installation des dependances  \n"
	printf "    Fin de l'installation des dependances  \n"
	printf "    Fin de l'installation des dependances  \n"
	printf "    Fin de l'installation des dependances  \n"
	printf "  =========================================\n"
	sleep 2
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "all" ]; then
	printf "  =========================================\n"
	printf "            Installation de nodeJs    \n"
	printf "            Installation de nodeJs    \n"
	printf "            Installation de nodeJs    \n"
	printf "            Installation de nodeJs    \n"
	printf "  =========================================\n"
	cd ~ && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	. ./.nvm/nvm.sh
	nvm install 18 && \
	nvm install 16 && \
	nvm use 18
	printf "  =========================================\n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "  =========================================\n"
	sleep 2
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "all" ]; then
	printf "  =========================================\n"
	printf "             Installation de rust      \n"
	printf "             Installation de rust      \n"
	printf "             Installation de rust      \n"
	printf "             Installation de rust      \n"
	printf "  =========================================\n"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	printf "  =========================================\n"
	printf "        Fin de l'installation de rust      \n"
	printf "        Fin de l'installation de rust      \n"
	printf "        Fin de l'installation de rust      \n"
	printf "        Fin de l'installation de rust      \n"
	printf "  =========================================\n"
	sleep 2
fi

# GIT
if [ "$choice" = "git" ] || [ "$choice" = "all" ]; then
	sudo apt install -y git
	read -p "Ton email ? : " EmailGit

	if [ "$EmailGit" = "" ]; then
		printf "\n"
		printf "Tu dois rentrer un email valide\n"
		continue
	fi

	read -p "Ton nom ? : " NameGit	
	if [ "$NameGit" = "" ]; then
		printf "\n"
		printf "Tu dois rentrer un nom valide\n"
		continue
	fi

	git config --global user.name "$NameGit" && \
	printf "git config --global user.name "$NameGit" \n"
	git config --global user.email "$EmailGit" && \
	printf "git config --global user.email "$EmailGit" \n"
	git config --global init.defaultBranch main && \
	printf "git config --global init.defaultBranch main \n"

	cd $HOME/.ssh 
	ssh-keygen -t ed25519 -C "$EmailGit"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat $HOME/.ssh/id_ed25519.pub
	printf "  =========================================\n"
	printf "     Fin de l'installation de l'auth git   \n"
	printf "  =========================================\n"
	sleep 1
fi

# DOTFOLDERS
if [ "$choice" = "dotfolders" ] || [ "$choice" = "all" ]; then
	mkdir -p $HOME/dev &&\
	mkdir -p $HOME/apps &&\
	mkdir -p $HOME/downloads &&\
	printf "  =========================================\n"
	printf "          Les dossiers ont été crées       \n"
	printf "  =========================================\n"
	sleep 1
	sudo rm -rf $HOME/Bureau $HOME/Images $HOME/Musique $HOME/Vidéos $HOME/Documents $HOME/Modèles $HOME/Public $HOME/Téléchargements
	printf "  =========================================\n"
	printf "   Les dossiers inutiles ont été supprimés \n"
	printf "  =========================================\n"
	sleep 1
	cd $HOME 
	printf "$CR Liens git clone ssh des dotfiles\n $CRS"
	read -p "Adresse de vos dotfiles " dotfiles
	printf "Le dossier sera crée à la racine ~/dotfiles \n"

	if [ ! -d "$HOME/dotfiles" ]; then
		printf "Le dossier de destination n'existe pas. Création du dossier..."
		mkdir -p "$HOME/dotfiles"
	fi

	git clone "$dotfiles" "$HOME/dotfiles"

	if [ $? -eq 0 ]; then
		printf "Le dépôt a été cloné avec succès dans $HOME/dotfiles"
		else
		printf "Une erreur s'est produite lors du clonage du dépôt."
	fi
	printf "  =========================================\n"
	printf "      Fin de l'installation des dotfiles   \n"
	printf "  =========================================\n"
	sleep 1
fi

# OHMYZSH
if [ "$choice" = "oh" ] || [ "$choice" = "all" ]; then
	printf "  =========================================\n"
	printf "         Installation de ohmyzsh    \n"
	printf "         Installation de ohmyzsh    \n"
	printf "         Installation de ohmyzsh    \n"
	printf "         Installation de ohmyzsh    \n"
	printf "  =========================================\n"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cd $HOME
	if [ -e .zshrc ]; then
		echo "Suppression du fichier .zshrc"
		sudo rm .zshrc
	fi
	cd $HOME/dotfiles
	stow -t $HOME zsh
	stow -t $HOME .oh-my-zsh/custom/themes oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	printf "  =========================================\n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "  =========================================\n"
	sleep 2
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "     FERMEZ LE TERMINAL ET LA SESSION      \n"
	printf "     FERMEZ LE TERMINAL ET LA SESSION      \n"
	printf "     FERMEZ LE TERMINAL ET LA SESSION      \n"
	printf "     FERMEZ LE TERMINAL ET LA SESSION      \n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done

