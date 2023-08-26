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
printf "   	q -- Quitter le script                 \n"

read -p "Votre choix ?" choice

if [ "$choice" = "1" ]; then
	cd ~
	sudo apt update
	sudo apt Upgrade
fi

if [ "$choice" = "q" ]; then
	printf "Bye"
	exit 1
fi
