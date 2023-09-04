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
	printf "  $CB folders $CRS     -- Préparation dossiers \n"
	printf "  $CB dep $CRS     -- Install dépendences \n"
	printf "  $CB gitdot $CRS     -- Install de l'env git \n"
	printf "  $CB oh $CRS     -- Install ohmyzsh \n"
	printf "  $CB ohfiles $CRS     -- Install fichiers ohmyzsh \n"
	printf "  $CB nvm $CRS     -- Install nvm \n"
	printf "  $CB node $CRS     -- Install nodeJs \n"
	printf "  $CB rust $CRS     -- Install rust \n"
	printf "  $CB neovim $CRS     -- Install neovim \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all -- $CRS Tout installer             \n"
	printf "  $CR q -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# FOLDERS
if [ "$choice" = "folders" ]; then
	printf "$CV Dossiers /Bureau, /Images, /Musique, /Vidéos, /Documents, /Modèles, /Public, /Téléchargements \n"
	printf " en cours de suppression... \n"
	sudo rm -rf $HOME/Bureau $HOME/Images $HOME/Musique $HOME/Vidéos $HOME/Documents $HOME/Modèles $HOME/Public $HOME/Téléchargements
	sleep 2
	printf " Dossiers /dev, /apps, /downloads \n"
	printf " en cours de création...$CRS \n"
	mkdir -p $HOME/dev $HOME/apps $HOME/downloads
	sleep 2
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# DEP
if [ "$choice" = "dep" ]; then
	printf "$CV Installation des dependances $CRS \n"
	sleep 2
	sudo apt update && sudo apt upgrade -y && \
	sudo apt install -y git curl compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget vim zsh && \
	sudo apt autoremove -y && \
	sudo apt autoclean -y
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# GITDOTFILES
if [ "$choice" = "gitdot" ]; then
	printf "$CV Installation de la clé ssh git $CRS \n"
	sleep 2
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
	ssh-add $HOME/.ssh/id_ed25519
	printf "$CR Clé ssh à copier coller \n"
	cat $HOME/.ssh/id_ed25519.pub $CRS
	printf "$CR Clé git crée $CRS      \n"
	sleep 2
	
	printf "$CV Récupération des dotfiles $CRS \n"
	sleep 2
	cd $HOME 
	printf "$CR Liens git clone ssh des dotfiles\n $CRS"
	read -p "Adresse de vos dotfiles " dotfiles
	printf " $CR Le dossier sera crée à la racine ~/dotfiles $CRS\n"
	sleep 2

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
	printf "$CR Dossier dotfiles récupéré et installé $CRS      \n"
	sleep 2
fi

# OHMYZSH 
if [ "$choice" = "oh" ]; then
	printf "$CV Installation de Oh my Zsh $CRS \n"
	sleep 2
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	zenity --info --text="Fermez le terminal\n Logout et Login\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# OHMYZSHFILES 
if [ "$choice" = "ohfiles" ]; then
	printf "$CV Installation des plugins Oh my Zsh $CRS \n"
	sleep 2
	cd $HOME
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	printf "$CV Récupération du thème Oh my zsh $CRS \n"
	stow -t $HOME/.oh-my-zsh/custom/themes oh-my-zsh
	sleep 2
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# NVM
if [ "$choice" = "nvm" ]; then
	printf "$CV Installation de node version manager $CRS \n"
	sleep 2
	cd $HOME && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des versions 16 et 18 de nodeJs $CRS \n"
	sleep 2
	nvm install 18 && nvm install 16 && nvm use 18
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Rust & Cargo $CRS \n"
	sleep 2
	cd $HOME
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# NEOVIM 
if [ "$choice" = "neovim" ] || [ "$choice" = "second" ]; then
	printf "$CV Installation de Neovim $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt install build-essential software-properties-common -y
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt-get update && sudo apt install neovim -y
	printf "$CR Neovim est installé $CRS \n"
	sleep 2

	printf "$CV Installation de pynvim $CRS \n"
	sleep 2
	cd $HOME
	pip3 install pynvim
	printf "$CR Pynvim est installé $CRS \n"
	sleep 2
	
	printf "$CV Installation de Packer $CRS \n"
	sleep 2
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "$CR Packer est installé $CRS \n"
	sleep 2

	printf "$CV Installation de tree-sitter-cli $CRS \n"
	sleep 2
	cd $HOME 
	npm i -g tree-sitter-cli
	printf "$CR tree-sitter-cli est installé $CRS \n"
	sleep 2

	printf "$CV Installation de neovim-cli $CRS \n"
	sleep 2
	cd $HOME
	npm i -g neovim
	printf "$CR neovim-cli est installé $CRS \n"
	sleep 2

	printf "$CV Récupération des dotfiles neovim $CRS \n"
	sleep 2
	mkdir ~/.config/nvim
	cd $HOME/dotfiles
	stow -t $HOME/.config/nvim neovim
	zenity --info --text="Ouvrez packer.lua pour installer les paquets\n puis exécutez :PackerSync" --width=$dialog_width --height=$dialog_height
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

