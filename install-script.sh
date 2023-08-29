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

printf "\n"
printf "  =============================================\n"
printf "    $CR Script d'installation Web dev Ubuntu   \n"
printf "             by Moumax (v1.00) $CRS            \n"
printf "  =============================================\n"
printf "\n"
printf "\n"
printf "  ----------------MAINTENANCE------------------\n"
printf "\n"
printf "  $CB update $CRS  -- Update du système       \n"
printf "\n"
printf "  ----------------DEPENDANCES------------------\n"
printf "\n"
printf "  $CB dep $CRS     -- Install des dépendances    \n"
printf "  $CB noderust $CRS-- Install de nodeJS & rust   \n"
printf "  $CB folders $CRS -- Archi des dossiers    \n"
printf "  $CB chrome $CRS  -- Install de chrome   \n"
printf "\n"
printf "  ----------------ENVIRONNEMENT----------------\n"
printf "\n"
printf "  $CB git $CRS     -- Install de l'env git \n"
printf "  $CB dot $CRS     -- Install des dotfiles \n"
printf "\n"
printf "  --------------------OUTILS-------------------\n"
printf "\n"
printf "  $CB ohmyzsh $CRS -- Install d'oh my zsh    \n"
printf "  $CB font $CRS    -- Install la font hack      \n"
printf "  $CB alacr $CRS   -- Install Alacritty    \n"
printf "  $CB stars $CRS   -- Install de Starship   \n"
printf "  $CB fzf $CRS     -- Install de fzf             \n"
printf "  $CB gitui $CRS   -- Install de gitui         \n"
printf "  $CB btop $CRS    -- Install de btop           \n"
printf "  $CB glow $CRS    -- Install de glow           \n"
printf "  $CB tmux $CRS    -- Install de tmux           \n"
printf "\n"
printf "  -------------------NEOVIM--------------------\n"
printf "\n"
printf "  $CB packer $CRS  -- Install de packer       \n"
printf "  $CB pynvim $CRS  -- Install de pynvim       \n"
printf "  $CB neovim $CRS  -- Install de neovim       \n"
printf "  ---------------------I3----------------------\n"
printf "\n"
printf "  $CB rofi $CRS    -- Install de rofi           \n"
printf "  $CB polybar $CRS -- Install de polybar     \n"
printf "  $CB i3-conf $CRS -- Fichiers de config i3 \n"
printf "  ---------------------------------------------\n"
printf "  $CR q -- $CRS Quitter le script             \n"
printf "\n"

read -p "Votre choix ? " choice

# UPDATE
if [ "$choice" = "update" ]; then
	cd ~
	sudo apt upgrade
	sudo apt update
	printf "  =========================================\n"
	printf "            Fin de la mise à jour          \n"
	printf "  =========================================\n"
fi

# DEPENDANCES
if [ "$choice" = "dep" ]; then
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install -y git  curl i3 rofi compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget && \
	sudo apt autoremove -y && \
	sudo apt autoclean -y
	printf "  =========================================\n"
	printf "    Fin de l'installation des dependances  \n"
	printf "  =========================================\n"
fi

# NODERUST
if [ "$choice" = "noderust" ]; then
	cd ~ && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install 18 && \
	nvm install 16 && \
	nvm use 18
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	printf "  =========================================\n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "        Fin de l'installation de rust      \n"
	printf "  =========================================\n"
fi

# FOLDERS
if [ "$choice" = "folders" ]; then
	mkdir -p ~/dev &&\
	mkdir -p ~/apps &&\
	mkdir -p ~/downloads &&\
	sudo rm -rf ~/Bureau ~/Images ~/Musique ~/Vidéos ~/Documents ~/Modèles ~/Public ~/Téléchargements
	printf "  =========================================\n"
	printf "          Les dossiers ont été crées       \n"
	printf "  =========================================\n"
fi

# CHROME
if [ "$choice" = "chrome" ]; then
	cd ~/apps && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	google-chrome
	printf "  =========================================\n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "  =========================================\n"

fi

# GIT
if [ "$choice" = "git" ]; then
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

	cd ~/.ssh 
	ssh-keygen -t ed25519 -C "$EmailGit"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub
	printf "  =========================================\n"
	printf "     Fin de l'installation de l'auth git   \n"
	printf "  =========================================\n"
fi

# DOTFILES
if [ "$choice" = "dot" ]; then
	cd ~ 
	read -p "Adresse de vos dotfiles " dotfiles
	printf "Le dossier sera crée dans votre fichier perso home/votrePseudo/LeDossier \n"
	printf "exemple : dev/dotfiles -- clonera dans home/votrePseudo/dev/dotfiles\n"
	read -p "Dossier destinataire " folderToPaste
	if [ ! -d "$folderToPaste" ]; then
		printf "Le dossier de destination n'existe pas. Création du dossier..."
		mkdir -p "$folderToPaste"
	fi

	git clone "$dotfiles" "$folderToPaste"

	if [ $? -eq 0 ]; then
		printf "Le dépôt a été cloné avec succès dans $folderToPaste."
	else
		printf "Une erreur s'est produite lors du clonage du dépôt."
	fi
	printf "  =========================================\n"
	printf "      Fin de l'installation des dotfiles   \n"
	printf "  =========================================\n"
fi

# OHMYZSH
if [ "$choice" = "ohmyzsh" ]; then
	cd ~/ && \
	sudo apt install zsh zsh-syntax-highlighting
	stow -t ~/ zsh 
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cd ~/dev/dotfiles
	stow -t ~/.oh-my-zsh/custom/themes oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	zenity --info --text="Fermez le terminal, logout, login" --width=$dialog_width --height=$dialog_height
	printf "  =========================================\n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "  =========================================\n"
fi

# FONT
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

# ALACRITTY
if [ "$choice" = "alacr" ]; then
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

# STARSHIP
if [ "$choice" = "stars" ]; then
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

# FZF
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

# GITUI
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

# BTOP
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

# GLOW
if [ "$choice" = "glow" ]; then
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation de glow      \n"
	printf "  =========================================\n"
fi

# TMUX (A TESTER) 
if [ "$choice" = "tmux" ]; then
	cd ~ && \
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt remove tmux && \
	sudo apt autoremove -y && \
	rm -rf .tmux
	sudo apt install -y libevent-dev ncurses-dev build-essential bison	
	git clone https://github.com/tmux/tmux.git ~/apps/tmux
	cd ~/apps/tmux && \
	sh autogen.sh && \
	./configure && \
	make && \
	sudo make install
	git clone https://github.com/tmux-plugins/tpm ~/tmux/.tmux/plugins/tpm && \
	git clone https://github.com/erikw/tmux-powerline.git ~/tmux/.tmux/plugins/tmux-powerline
	cd ~/dev/dotfiles 
	stow -t ~/tmux tmux
	mv ~/tmux/.tmux/plugins/tmux-powerline/themes/default.sh ~/tmux/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
	ln -s ~/dev/dotfiles/tmux/.tmux/tmux-powerline-custom-themes/marco-theme.sh ~/tmux/.tmux/plugins/tmux-powerline/themes/default.sh
	printf "  =========================================\n"
	printf "        Fin de l'installation de tmux      \n"
	printf "  =========================================\n"
fi

# PACKER
if [ "$choice" = "packer" ]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "  =========================================\n"
	printf "        Fin de l'installation de packer    \n"
	printf "  =========================================\n"
fi

# PYNVIM
if [ "$choice" = "pynvim" ]; then
	cd ~ && \
	pip3 install pynvim --break-system-packages
	printf "  =========================================\n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "  =========================================\n"
fi

# NEOVIM (A TESTER) 
if [ "$choice" = "neovim" ]; then
	cd ~ && \
	sudo apt install build-essential software-properties-common -y
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt-get update
	sudo apt install neovim -y
	mkdir ~/.config/nvim
	npm i -g tree-sitter-cli && \
	npm i -g neovim
	cd ~/dev/dotfiles
	stow -t ~/.config/nvim neovim
	zenity --info --text="ouvrez packer.lua pour installer les paquets\n puis exécutez :PackerSync" --width=$dialog_width --height=$dialog_height
	printf "  =========================================\n"
	printf "  Pour terminer la configuration de neovim \n"
	printf "  Rendez-vous dans packer.lua pour install \n"
	printf "  les dépendances                          \n"
	printf "\n"
	printf "        Fin de l'installation de neovim    \n"
	printf "  =========================================\n"
fi

# ROFI 
if [ "$choice" = "rofi" ]; then
	mkdir ~/.config/rofi && \
	cd ~/dev/dotfiles && \
	stow -t ~/.config/rofi rofi
	printf "  =========================================\n"
	printf "        Fin de l'installation de rofi      \n"
	printf "  =========================================\n"
fi

# POLYBAR 
if [ "$choice" = "polybar" ]; then
	cd ~/ && \
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install -y git cmake build-essential cmake-data pkg-config python3-sphinx \
	libuv1-dev libcairo2-dev libxcb1-dev libcurl4-openssl-dev libnl-genl-3-dev \
	libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen \
	xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev \
	libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm \
	libjsoncpp-dev libmpdclient-dev python3-packaging && \
	sudo apt autoremove -y
	wget -P ~/downloads https://github.com/polybar/polybar/releases/download/3.6.3/polybar-3.6.3.tar.gz && \
	cd ~/downloads && \
	tar xvzf polybar-3.6.3.tar.gz && \
	rm -rf polybar-3.6.3.tar.gz
	mv polybar-3.6.3 ~/apps/Polybar-3.6.3 && \
	cd ~/apps/Polybar-3.6.3 && \
	mkdir build && \
	cd build
	cmake .. && \
	make -j$(nproc) && \
	sudo make install
	mkdir ~/.config/polybar && \
	cd ~/dev/dotfiles && \
	stow -t ~/.config/polybar polybar
	chmod +x ~/.config/polybar/polybar.sh && \
	cd ~ && \
	sudo apt install -y fonts-font-awesome
	printf "  =========================================\n"
	printf "        Fin de l'installation de polybar   \n"
	printf "  =========================================\n"
fi

# I3-CONFIG
if [ "$choice" = "i3-conf" ]; then
	mkdir ~/.config/i3
	cd ~/dev/dotfiles && \
	stow -t ~/.config/i3 i3
	printf "  =========================================\n"
	printf "        Fin de l'installation d'i3         \n"
	printf "  =========================================\n"
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi
