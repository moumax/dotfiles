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

if ! which node > /dev/null; then
		printf "\n"
		printf "  ================================================\n"
		printf "                                                  \n"
		printf "                  I am sorry ...                  \n"
		printf "                                                  \n"
		printf "        You need to install node.js first !       \n"
		printf "                                                  \n"
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
	printf "  ----------------MAINTENANCE------------------\n"
	printf "\n"
	printf "  $CB update $CRS  -- Update du système       \n"
	printf "\n"
	printf "  --------------------OUTILS-------------------\n"
	printf "\n"
	printf "  $CB chrome $CRS  -- Install de chrome   \n"
	printf "  $CB font $CRS    -- Install la font hack      \n"
	printf "  $CB alacr $CRS   -- Install Alacritty    \n"
	printf "  $CB stars $CRS   -- Install de Starship   \n"
	printf "  $CB fzf $CRS     -- Install de fzf             \n"
	printf "  $CB gitui $CRS   -- Install de gitui         \n"
	printf "  $CB btop $CRS    -- Install de btop           \n"
	printf "  $CB glow $CRS    -- Install de glow           \n"
	printf "  $CB tmux $CRS    -- Install de tmux           \n"
	printf "  $CB insomnia $CRS-- Install de insomnia   \n"
	printf "  $CB dbeaver $CRS -- Install de dbeaver \n"
	printf "  $CB vscode $CRS  -- Install de vscode  \n"
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
	printf "  $CB first $CRS   --  Premier script \n"
	printf "  $CB second $CRS  --  Tout installer     \n"
	printf "  $CR q $CRS       --  Quitter le script    \n"
	printf "\n"

	read -p "Votre choix ? " choice

# UPDATE
if [ "$choice" = "update" ] || [ "$choice" = "first" ]; then
	printf "  =========================================\n"
	printf "              Update du système          \n"
	printf "              Update du système          \n"
	printf "              Update du système          \n"
	printf "              Update du système          \n"
	printf "  =========================================\n"
	cd ~
	sudo apt update
	sudo apt upgrade -y
	printf "  =========================================\n"
	printf "            Fin de la mise à jour          \n"
	printf "            Fin de la mise à jour          \n"
	printf "            Fin de la mise à jour          \n"
	printf "            Fin de la mise à jour          \n"
	printf "  =========================================\n"
	sleep 2
fi

# CHROME
if [ "$choice" = "chrome" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "            Installation de Chrome    \n"
	printf "            Installation de Chrome    \n"
	printf "            Installation de Chrome    \n"
	printf "            Installation de Chrome    \n"
	printf "  =========================================\n"
	cd $HOME/apps && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	printf "  =========================================\n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "  =========================================\n"
	sleep 2
fi

# FONT
if [ "$choice" = "font" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "          Installation de la font    \n"
	printf "          Installation de la font    \n"
	printf "          Installation de la font    \n"
	printf "          Installation de la font    \n"
	printf "  =========================================\n"
	wget -P $HOME/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip && \
	cd $HOME/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv $HOME/downloads/Hack.zip . && \
	unzip Hack.zip
	printf "  =========================================\n"
	printf "       Fin de l'installation de la font    \n"
	printf "       Fin de l'installation de la font    \n"
	printf "       Fin de l'installation de la font    \n"
	printf "       Fin de l'installation de la font    \n"
	printf "  =========================================\n"
	sleep 2
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "          Installation d'Alacritty    \n"
	printf "          Installation d'Alacritty    \n"
	printf "          Installation d'Alacritty    \n"
	printf "          Installation d'Alacritty    \n"
	printf "  =========================================\n"
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install -y alacritty
	mkdir -p $HOME/.config/alacritty
	cd $HOME/dotfiles
	stow -t $HOME/.config/alacritty alacritty
	printf "  =========================================\n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "  =========================================\n"
	sleep 2
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "         Installation de starship    \n"
	printf "         Installation de starship    \n"
	printf "         Installation de starship    \n"
	printf "         Installation de starship    \n"
	printf "  =========================================\n"
	cd $HOME && \
	curl -sS https://starship.rs/install.sh | sh
	mkdir -p $HOME/.config/starship
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/starship starship
	printf "  =========================================\n"
	printf "      Fin de l'installation de starship    \n"
	printf "      Fin de l'installation de starship    \n"
	printf "      Fin de l'installation de starship    \n"
	printf "      Fin de l'installation de starship    \n"
	printf "  =========================================\n"
	sleep 2
fi

# FZF
if [ "$choice" = "fzf" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "            Installation de fzf      \n"
	printf "            Installation de fzf      \n"
	printf "            Installation de fzf      \n"
	printf "            Installation de fzf      \n"
	printf "  =========================================\n"
	cd $HOME && \
	git clone https://github.com/junegunn/fzf $HOME/.fzf && \
	cd $HOME/.fzf && ./install
	printf "  =========================================\n"
	printf "         Fin de l'installation de fzf      \n"
	printf "         Fin de l'installation de fzf      \n"
	printf "         Fin de l'installation de fzf      \n"
	printf "         Fin de l'installation de fzf      \n"
	printf "  =========================================\n"
	sleep 2
fi

# GITUI
if [ "$choice" = "gitui" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de gitui     \n"
	printf "           Installation de gitui     \n"
	printf "           Installation de gitui     \n"
	printf "           Installation de gitui     \n"
	printf "  =========================================\n"
	cd $HOME && \
	cargo install gitui
	mkdir $HOME/.config/gitui && \
	cd $HOME/dotfiles
	stow -t $HOME/.config/gitui gitui
	printf "  =========================================\n"
	printf "        Fin de l'installation de gitui     \n"
	printf "        Fin de l'installation de gitui     \n"
	printf "        Fin de l'installation de gitui     \n"
	printf "        Fin de l'installation de gitui     \n"
	printf "  =========================================\n"
	sleep 2
fi

# GLOW
if [ "$choice" = "glow" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "            Installation de glow      \n"
	printf "            Installation de glow      \n"
	printf "            Installation de glow      \n"
	printf "            Installation de glow      \n"
	printf "  =========================================\n"
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation de glow      \n"
	printf "        Fin de l'installation de glow      \n"
	printf "        Fin de l'installation de glow      \n"
	printf "        Fin de l'installation de glow      \n"
	printf "  =========================================\n"
	sleep 2
fi

# TMUX (A TESTER) 
if [ "$choice" = "tmux" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "            Installation de tmux      \n"
	printf "            Installation de tmux      \n"
	printf "            Installation de tmux      \n"
	printf "            Installation de tmux      \n"
	printf "  =========================================\n"
	cd $HOME && \
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt remove tmux && \
	sudo apt autoremove -y && \
	rm -rf .tmux
	sudo apt install -y libevent-dev ncurses-dev build-essential bison tmux	
	cd $HOME && \
	mkdir .tmux .tmux/tmux-powerline-custom-themes
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm && \
	git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
	cd $HOME/dotfiles 
	stow -t $HOME/ tmux
	mv $HOME/.tmux/plugins/tmux-powerline/themes/default.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
	ln -s $HOME/dotfiles/tmux/.tmux/tmux-powerline-custom-themes/marco-theme.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh
	printf "  =========================================\n"
	printf "        Fin de l'installation de tmux      \n"
	printf "        Fin de l'installation de tmux      \n"
	printf "        Fin de l'installation de tmux      \n"
	printf "        Fin de l'installation de tmux      \n"
	printf "  =========================================\n"
	sleep 2
fi

# PACKER
if [ "$choice" = "packer" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de packer    \n"
	printf "           Installation de packer    \n"
	printf "           Installation de packer    \n"
	printf "           Installation de packer    \n"
	printf "  =========================================\n"
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "  =========================================\n"
	printf "        Fin de l'installation de packer    \n"
	printf "        Fin de l'installation de packer    \n"
	printf "        Fin de l'installation de packer    \n"
	printf "        Fin de l'installation de packer    \n"
	printf "  =========================================\n"
	sleep 2
fi

# PYNVIM
if [ "$choice" = "pynvim" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de pynvim    \n"
	printf "           Installation de pynvim    \n"
	printf "           Installation de pynvim    \n"
	printf "           Installation de pynvim    \n"
	printf "  =========================================\n"
	cd $HOME && \
	pip3 install pynvim --break-system-packages
	printf "  =========================================\n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "  =========================================\n"
	sleep 2
fi

# NEOVIM 
if [ "$choice" = "neovim" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "        Installation de neovim    \n"
	printf "        Installation de neovim    \n"
	printf "        Installation de neovim    \n"
	printf "        Installation de neovim    \n"
	printf "  =========================================\n"
	cd $HOME && \
	sudo apt install build-essential software-properties-common -y
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt-get update && sudo apt install neovim -y
	mkdir ~/.config/nvim
	npm i -g tree-sitter-cli
	npm i -g neovim
	cd $HOME/dotfiles
	stow -t $HOME/.config/nvim neovim
	zenity --info --text="ouvrez packer.lua pour installer les paquets\n puis exécutez :PackerSync" --width=$dialog_width --height=$dialog_height
	printf "  =========================================\n"
	printf "  Pour terminer la configuration de neovim \n"
	printf "  Rendez-vous dans packer.lua pour install \n"
	printf "  les dépendances                          \n"
	printf "\n"
	printf "        Fin de l'installation de neovim    \n"
	printf "        Fin de l'installation de neovim    \n"
	printf "        Fin de l'installation de neovim    \n"
	printf "        Fin de l'installation de neovim    \n"
	printf "  =========================================\n"
	sleep 2
fi

# ROFI 
if [ "$choice" = "rofi" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de rofi      \n"
	printf "           Installation de rofi      \n"
	printf "           Installation de rofi      \n"
	printf "           Installation de rofi      \n"
	printf "  =========================================\n"
	cd $HOME && sudo apt install -y rofi
	mkdir ~/.config/rofi &&	cd $HOME/dotfiles
	stow -t ~/.config/rofi rofi
	printf "  =========================================\n"
	printf "        Fin de l'installation de rofi      \n"
	printf "        Fin de l'installation de rofi      \n"
	printf "        Fin de l'installation de rofi      \n"
	printf "        Fin de l'installation de rofi      \n"
	printf "  =========================================\n"
	sleep 2
fi

# POLYBAR 
if [ "$choice" = "polybar" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de polybar   \n"
	printf "           Installation de polybar   \n"
	printf "           Installation de polybar   \n"
	printf "           Installation de polybar   \n"
	printf "  =========================================\n"
	cd $HOME && \
	sudo apt install -y polybar
	sudo apt autoremove -y
	mkdir $HOME/.config/polybar && \
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/polybar polybar
	chmod +x $HOME/.config/polybar/polybar.sh && \
	cd $HOME && \
	sudo apt install -y fonts-font-awesome
	printf "  =========================================\n"
	printf "        Fin de l'installation de polybar   \n"
	printf "        Fin de l'installation de polybar   \n"
	printf "        Fin de l'installation de polybar   \n"
	printf "        Fin de l'installation de polybar   \n"
	printf "  =========================================\n"
	sleep 2
fi

# I3-CONFIG
if [ "$choice" = "i3-conf" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "             Installation d'i3         \n"
	printf "             Installation d'i3         \n"
	printf "             Installation d'i3         \n"
	printf "             Installation d'i3         \n"
	printf "  =========================================\n"
	mkdir $HOME/.config/i3
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/i3 i3
	printf "  =========================================\n"
	printf "        Fin de l'installation d'i3         \n"
	printf "        Fin de l'installation d'i3         \n"
	printf "        Fin de l'installation d'i3         \n"
	printf "        Fin de l'installation d'i3         \n"
	printf "  =========================================\n"
	sleep 2
fi

# INSOMNIA
if [ "$choice" = "insomnia" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation d'insomnia   \n"
	printf "           Installation d'insomnia   \n"
	printf "           Installation d'insomnia   \n"
	printf "           Installation d'insomnia   \n"
	printf "  =========================================\n"
	cd $HOME && \
	echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
	sudo apt update && \
	sudo apt install -y insomnia && \
	sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation d'insomnia   \n"
	printf "        Fin de l'installation d'insomnia   \n"
	printf "        Fin de l'installation d'insomnia   \n"
	printf "        Fin de l'installation d'insomnia   \n"
	printf "  =========================================\n"
	sleep 2
fi

# DBEAVER
if [ "$choice" = "dbeaver" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "        Installation de dbeaver   \n"
	printf "        Installation de dbeaver   \n"
	printf "        Installation de dbeaver   \n"
	printf "        Installation de dbeaver   \n"
	printf "  =========================================\n"
	cd $HOME && \
	sudo add-apt-repository ppa:serge-rider/dbeaver-ce && \
	sudo apt update && sudo apt install -y dbeaver-ce
	printf "  =========================================\n"
	printf "        Fin de l'installation de dbeaver   \n"
	printf "        Fin de l'installation de dbeaver   \n"
	printf "        Fin de l'installation de dbeaver   \n"
	printf "        Fin de l'installation de dbeaver   \n"
	printf "  =========================================\n"
	sleep 2
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "second" ]; then
	printf "  =========================================\n"
	printf "           Installation de vscode \n"
	printf "           Installation de vscode \n"
	printf "           Installation de vscode \n"
	printf "           Installation de vscode \n"
	printf "  =========================================\n"
	cd $HOME && \
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install -y apt-transport-https
	sudo apt update && sudo apt install -y code
	printf "  =========================================\n"
	printf "        Fin de l'installation de vscode \n"
	printf "        Fin de l'installation de vscode \n"
	printf "        Fin de l'installation de vscode \n"
	printf "        Fin de l'installation de vscode \n"
	printf "  =========================================\n"
	sleep 2
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "                Fin du script              \n"
	printf "                Fin du script              \n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done
