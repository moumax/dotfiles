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
printf "  =========================================\n"
printf "    Script d'installation Web dev Ubuntu   \n"
printf "  =========================================\n"
printf "\n"
printf "  =========================================\n"
printf "           Sélectionnez un choix           \n"
printf "\n"
printf "   	1 -- Update et Upgrade du système      \n"
printf "   	2 -- Création de l'archi dossier       \n"
printf "   	3 -- Intallation de Alacritty          \n"
printf "   	q -- Quitter le script                 \n"

read -p "Votre choix ?" choice

if [ "$choice" = "1" ]; then
	cd ~
	sudo apt upgrade
	sudo apt update
	printf "  =========================================\n"
	printf "            Fin de la mise à jour          \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "2" ]; then
	mkdir ~/dev &&\
	mkdir ~/apps &&\
	mkdir ~/downloads &&\
	sudo rm -rf ~/Bureau ~/Images ~/Musique ~/Vidéos ~/Documents ~/Modèles ~/Public ~/Téléchargements
	printf "  =========================================\n"
	printf "          Les dossiers ont été crées       \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "3" ]; then
	sudo apt update && sudo apt upgrade
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install alacritty
	mkdir -p ~/.config/alacritty
	stow -t ~/.config/alacritty alacritty
	printf "  =========================================\n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "q" ]; then
	printf "Bye"
	exit 1
fi
