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
	printf "  ----------------MAINTENANCE------------------\n"
	printf "\n"
	printf "  $CB update $CRS  -- Update du système       \n"
	printf "\n"
	printf "  ----------------DEPENDANCES------------------\n"
	printf "\n"
	printf "  $CB dep $CRS     -- Install des dépendances    \n"
	printf "  $CB noderust $CRS-- Install de nodeJS & rust   \n"
	printf "  $CB chrome $CRS  -- Install de chrome   \n"
	printf "\n"
	printf "  --------------------OUTILS-------------------\n"
	printf "\n"
	printf "  $CB zsh $CRS      -- Install de zsh    \n"
	printf "  $CB oh $CRS      -- Install d'oh my zsh    \n"
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
	printf "  $CB all -- $CRS Tout installer             \n"
	printf "  $CR q -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# UPDATE
if [ "$choice" = "update" ] || [ "$choice" = "all" ]; then
	cd ~
	sudo apt update
	sudo apt upgrade -y
	printf "  =========================================\n"
	printf "            Fin de la mise à jour          \n"
	printf "  =========================================\n"
	sleep 1
fi

# DEPENDANCES
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install -y git curl i3 rofi compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget vim && \
	sudo apt autoremove -y && \
	sudo apt autoclean -y
	printf "  =========================================\n"
	printf "    Fin de l'installation des dependances  \n"
	printf "  =========================================\n"
	sleep 1
fi

# NODERUST
if [ "$choice" = "noderust" ] || [ "$choice" = "all" ]; then
	cd ~ && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	sudo nvm install 18 && \
	sudo nvm install 16 && \
	sudo nvm use 18
	printf "  =========================================\n"
	printf "        Fin de l'installation de nodeJs    \n"
	printf "  =========================================\n"
	sleep 1
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	printf "  =========================================\n"
	printf "        Fin de l'installation de rust      \n"
	printf "  =========================================\n"
	sleep 1
fi

# CHROME
if [ "$choice" = "chrome" ] || [ "$choice" = "all" ]; then
	cd ~/apps && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	printf "  =========================================\n"
	printf "        Fin de l'installation de Chrome    \n"
	printf "  =========================================\n"
	sleep 1
fi

# ZSH&OHMYZSH
if [ "$choice" = "zsh" ] || [ "$choice" = "all" ]; then
	cd $HOME
	sudo apt install -y zsh zsh-syntax-highlighting
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	sudo rm -r .zshrc
	printf "  =========================================\n"
	printf "       Fin de l'installation de zsh    \n"
	printf "  =========================================\n"
	sleep 1
fi

# OHMYZSH
if [ "$choice" = "oh" ] || [ "$choice" = "all" ]; then
	cd $HOME/dotfiles
	stow -t $HOME/ zsh 
	stow -t $HOME/.oh-my-zsh/custom/themes oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	zenity --info --text="Fermez le terminal, logout, login" --width=$dialog_width --height=$dialog_height
	printf "  =========================================\n"
	printf "       Fin de l'installation de ohmyzsh    \n"
	printf "  =========================================\n"
	sleep 1
fi

# FONT
if [ "$choice" = "font" ] || [ "$choice" = "all" ]; then
	wget -P ~/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip && \
	cd ~/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv ~/downloads/Hack.zip . && \
	unzip Hack.zip
	printf "  =========================================\n"
	printf "       Fin de l'installation de la font    \n"
	printf "  =========================================\n"
	sleep 1
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "all" ]; then
	sudo apt update && sudo apt upgrade -y
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install -y alacritty
	mkdir -p ~/.config/alacritty
	stow -t ~/.config/alacritty alacritty
	printf "  =========================================\n"
	printf "      Fin de l'installation d'Alacritty    \n"
	printf "  =========================================\n"
	sleep 1
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "all" ]; then
	cd ~/ && \
	curl -sS https://starship.rs/install.sh | sh
	mkdir -p ~/.config/starship
	cd $HOME/dotfiles && \
	stow -t ~/.config/starship starship
	printf "  =========================================\n"
	printf "      Fin de l'installation de starship    \n"
	printf "  =========================================\n"
	sleep 1
fi

# FZF
if [ "$choice" = "fzf" ] || [ "$choice" = "all" ]; then
	cd ~/ && \
	git clone https://github.com/junegunn/fzf ~/.fzf && \
	cd ~/.fzf && ./install
	printf "  =========================================\n"
	printf "         Fin de l'installation de fzf      \n"
	printf "  =========================================\n"
	sleep 1
fi

# GITUI
if [ "$choice" = "gitui" ] || [ "$choice" = "all" ]; then
	cd ~ && \
	cargo install gitui
	mkdir ~/.config/gitui && \
	cd $HOME/dotfiles
	stow -t ~/.config/gitui gitui
	printf "  =========================================\n"
	printf "        Fin de l'installation de gitui     \n"
	printf "  =========================================\n"
	sleep 1
fi

# BTOP
if [ "$choice" = "btop" ] || [ "$choice" = "all" ]; then
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
	printf "  =========================================\n"
	sleep 1
fi

# GLOW
if [ "$choice" = "glow" ] || [ "$choice" = "all" ]; then
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation de glow      \n"
	printf "  =========================================\n"
	sleep 1
fi

# TMUX (A TESTER) 
if [ "$choice" = "tmux" ] || [ "$choice" = "all" ]; then
	cd ~ && \
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt remove tmux && \
	sudo apt autoremove -y && \
	rm -rf .tmux
	sudo apt install -y libevent-dev ncurses-dev build-essential bison	
	sudo apt install -y tmux
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
	printf "  =========================================\n"
	sleep 1
fi

# PACKER
if [ "$choice" = "packer" ] || [ "$choice" = "all" ]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "  =========================================\n"
	printf "        Fin de l'installation de packer    \n"
	printf "  =========================================\n"
	sleep 1
fi

# PYNVIM
if [ "$choice" = "pynvim" ] || [ "$choice" = "all" ]; then
	cd ~ && \
	pip3 install pynvim --break-system-packages
	printf "  =========================================\n"
	printf "        Fin de l'installation de pynvim    \n"
	printf "  =========================================\n"
	sleep 1
fi

# NEOVIM 
if [ "$choice" = "neovim" ] || [ "$choice" = "all" ]; then
	cd ~ && \
	sudo apt install build-essential software-properties-common -y
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt-get update
	sudo apt install neovim -y
	mkdir ~/.config/nvim
	npm i -g tree-sitter-cli && \
	npm i -g neovim
	cd $HOME/dotfiles
	stow -t ~/.config/nvim neovim
	zenity --info --text="ouvrez packer.lua pour installer les paquets\n puis exécutez :PackerSync" --width=$dialog_width --height=$dialog_height
	printf "  =========================================\n"
	printf "  Pour terminer la configuration de neovim \n"
	printf "  Rendez-vous dans packer.lua pour install \n"
	printf "  les dépendances                          \n"
	printf "\n"
	printf "        Fin de l'installation de neovim    \n"
	printf "  =========================================\n"
	sleep 1
fi

# ROFI 
if [ "$choice" = "rofi" ] || [ "$choice" = "all" ]; then
	mkdir ~/.config/rofi && \
	cd $HOME/dotfiles && \
	stow -t ~/.config/rofi rofi
	printf "  =========================================\n"
	printf "        Fin de l'installation de rofi      \n"
	printf "  =========================================\n"
	sleep 1
fi

# POLYBAR 
if [ "$choice" = "polybar" ] || [ "$choice" = "all" ]; then
	cd $HOME && \
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
	cd $HOME/dotfiles && \
	stow -t ~/.config/polybar polybar
	chmod +x ~/.config/polybar/polybar.sh && \
	cd ~ && \
	sudo apt install -y fonts-font-awesome
	printf "  =========================================\n"
	printf "        Fin de l'installation de polybar   \n"
	printf "  =========================================\n"
	sleep 1
fi

# I3-CONFIG
if [ "$choice" = "i3-conf" ] || [ "$choice" = "all" ]; then
	mkdir ~/.config/i3
	cd $HOME/dotfiles && \
	stow -t ~/.config/i3 i3
	printf "  =========================================\n"
	printf "        Fin de l'installation d'i3         \n"
	printf "  =========================================\n"
	sleep 1
fi

# INSOMNIA
if [ "$choice" = "insomnia" ] || [ "$choice" = "all" ]; then
	echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
	sudo apt update && \
	sudo apt install -y insomnia && \
	sudo apt autoremove -y
	printf "  =========================================\n"
	printf "        Fin de l'installation d'insomnia   \n"
	printf "  =========================================\n"
	sleep 1
fi

# DBEAVER
if [ "$choice" = "dbeaver" ] || [ "$choice" = "all" ]; then
	sudo add-apt-repository ppa:serge-rider/dbeaver-ce && \
	sudo apt-get update && \
	sudo apt-get install -y dbeaver-ce
	printf "  =========================================\n"
	printf "        Fin de l'installation de dbeaver   \n"
	printf "  =========================================\n"
	sleep 1
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "all" ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install -y apt-transport-https
	sudo apt update
	sudo apt install -y code
	printf "  =========================================\n"
	printf "        Fin de l'installation de vscode \n"
	printf "  =========================================\n"
	sleep 1
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done
