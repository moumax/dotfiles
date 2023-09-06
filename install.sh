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
	printf "  $CB folders $CRS   -- Préparation dossiers \n"
	printf "  $CB dep $CRS       -- Install dépendences \n"
	printf "  $CB gitdot $CRS    -- Install de l'env git \n"
	printf "  $CB oh $CRS        -- Install ohmyzsh \n"
	printf "  $CB ohfiles $CRS   -- Install fichiers ohmyzsh \n"
	printf "  $CB nvm $CRS       -- Install nvm \n"
	printf "  $CB node $CRS      -- Install nodeJs \n"
	printf "  $CB rust $CRS      -- Install rust \n"
	printf "  $CB neovim $CRS    -- Install neovim \n"
	printf "  $CB font $CRS      -- Install hack font \n"
	printf "  $CB alacr $CRS     -- Install allacrity \n"
	printf "  $CB stars $CRS     -- Install de starship \n"
	printf "  $CB fzf $CRS       -- Install de fzf \n"
	printf "  $CB gitui $CRS     -- Install de gitui \n"
	printf "  $CB glow $CRS      -- Install de glow \n"
	printf "  $CB chrome $CRS    -- Install de google chrome \n"
	printf "  $CB tmux $CRS      -- Install de tmux \n"
	printf "  $CB polybar $CRS   -- Install de polybar \n"
	printf "  $CB rofi $CRS      -- Install de rofi \n"
	printf "  $CB i3-conf $CRS   -- Install des fichiers I3 \n"
	printf "  $CB insomnia $CRS  -- Install de insomnia \n"
	printf "  $CB dbeaver $CRS   -- Install de dbeaver \n"
	printf "  $CB vscode $CRS    -- Install de vscode \n"
	printf "  $CB btop $CRS      -- Install de btop \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB 1 -- $CRS Première phase d'installation \n"
	printf "  $CB 2 -- $CRS Seconde phase d'installation \n"
	printf "  $CB 3 -- $CRS Troisième phase d'installation \n"
	printf "  $CB 4 -- $CRS Quatrième phase d'installation \n"
	printf "  $CB 5 -- $CRS Cinquième phase d'installation \n"
	printf "  $CR q -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# FOLDERS
if [ "$choice" = "folders" ] || [ "$choice" = "1" ]; then
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
if [ "$choice" = "dep" ] || [ "$choice" = "1" ]; then
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
if [ "$choice" = "gitdot" ] || [ "$choice" = "1" ]; then
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
	printf "$CR Clé ssh à copier coller $CRS \n"
	cat $HOME/.ssh/id_ed25519.pub 
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
		printf "Le dépôt a été cloné avec succès dans $HOME/dotfiles \n"
		else
		printf "Une erreur s'est produite lors du clonage du dépôt. \n"
	fi
	printf "$CR Dossier dotfiles récupéré et installé $CRS      \n"
	sleep 2
fi

# OHMYZSH 
if [ "$choice" = "oh" ] || [ "$choice" = "1" ]; then
	printf "$CV Installation de Oh my Zsh $CRS \n"
	sleep 2
	zenity --info --text="Fermez le terminal\n Logout et Login\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# OHMYZSHFILES 
if [ "$choice" = "ohfiles" ] || [ "$choice" = "2" ]; then
	printf "$CV Installation des plugins Oh my Zsh $CRS \n"
	sleep 2
	cd $HOME
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	printf "$CV Récupération du thème Oh my zsh $CRS \n"
	cd $HOME/dotfiles
	sudo stow -t $HOME/.oh-my-zsh/custom/themes oh-my-zsh
	sudo rm $HOME/.zshrc && stow -t $HOME zsh
	sleep 2
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
	zenity --info --text="Fermez le terminal\n Logout et Login\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# NVM
if [ "$choice" = "nvm" ] || [ "$choice" = "3" ]; then
	printf "$CV Installation de node version manager $CRS \n"
	sleep 2
	cd $HOME && \
	mkdir -p .nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "4" ]; then
	printf "$CV Installation des versions 16 et 18 de nodeJs $CRS \n"
	sleep 2
	. .nvm/nvm.sh
	nvm install 18 && nvm install 16 && nvm use 18
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "4" ]; then
	printf "$CV Installation de Rust & Cargo $CRS \n"
	sleep 2
	cd $HOME
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
fi

# NEOVIM 
if [ "$choice" = "neovim" ] || [ "$choice" = "5" ]; then
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
	pip3 install pynvim --break-system-packages
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
	. .nvm/nvm.sh
	npm i -g tree-sitter-cli
	printf "$CR tree-sitter-cli est installé $CRS \n"
	sleep 2

	printf "$CV Installation de neovim-cli $CRS \n"
	sleep 2
	cd $HOME
	. .nvm/nvm.sh
	npm i -g neovim
	printf "$CR neovim-cli est installé $CRS \n"
	sleep 2

	printf "$CV Récupération des dotfiles neovim $CRS \n"
	sleep 2
	mkdir ~/.config/nvim
	cd $HOME/dotfiles
	stow -t $HOME/.config/nvim neovim
	printf "$CR Les dotfiles neovim ont été installés $CRS      \n"
	sleep 2
fi

# FONT
if [ "$choice" = "font" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de la font hack $CRS \n"
	sleep 2
	wget -P $HOME/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip && \
	cd $HOME/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv $HOME/downloads/Hack.zip . && \
	unzip Hack.zip
	printf "$CR La font hack a été installée $CRS      \n"
	sleep 2
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation d'alacritty $CRS \n"
	sleep 2
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install -y alacritty
	mkdir -p $HOME/.config/alacritty
	cd $HOME/dotfiles
	stow -t $HOME/.config/alacritty alacritty
	printf "$CR alacritty a été installée $CRS      \n"
	sleep 2
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de starship $CRS \n"
	sleep 2
	cd $HOME && \
	curl -sS https://starship.rs/install.sh | sh
	mkdir -p $HOME/.config/starship
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/starship starship
	printf "$CR starship a été installée $CRS      \n"
	sleep 2
fi

# FZF
if [ "$choice" = "fzf" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de fzf $CRS \n"
	sleep 2
	cd $HOME && \
	git clone https://github.com/junegunn/fzf $HOME/.fzf && \
	cd $HOME/.fzf && ./install
	printf "$CR fzf a été installée $CRS      \n"
	sleep 2
fi

# GITUI
if [ "$choice" = "gitui" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de gitui $CRS \n"
	sleep 2
	cd $HOME && \
	cargo install gitui
	mkdir $HOME/.config/gitui && \
	cd $HOME/dotfiles
	stow -t $HOME/.config/gitui gitui
	printf "$CR gitui a été installée $CRS      \n"
	sleep 2
fi

# GLOW
if [ "$choice" = "glow" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de glow $CRS \n"
	sleep 2
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "$CR glow a été installée $CRS      \n"
	sleep 2
fi

# CHROME
if [ "$choice" = "chrome" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de Google Chrome $CRS \n"
	sleep 2
	cd $HOME/apps && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	printf "$CR Google Chrome a été installée $CRS      \n"
	sleep 2
fi

# TMUX 
if [ "$choice" = "tmux" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de Tmux $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt remove tmux && \
	sudo apt install -y libevent-dev ncurses-dev build-essential bison tmux	
	sudo apt autoremove -y && \
	sudo rm -rf .tmux
	cd $HOME && \
	mkdir -p .tmux
	mkdir -p .tmux/tmux-powerline-custom-themes
	sudo apt install -y tmux
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm && \
	git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.powerlinerc"
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.conf"
	wget -P $HOME/.tmux/tmux-powerline-custom-themes "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/marco-theme.sh"
	mv $HOME/.tmux/plugins/tmux-powerline/themes/default.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
	ln -s $HOME/.tmux/tmux-powerline-custom-themes/marco-theme.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh
	printf "$CR Tmux a été installée $CRS      \n"
	sleep 2
fi

# POLYBAR 
if [ "$choice" = "polybar" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de Polybar $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt install -y polybar
	sudo apt autoremove -y
	mkdir $HOME/.config/polybar && \
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/polybar polybar
	chmod +x $HOME/.config/polybar/polybar.sh && \
	cd $HOME && \
	sudo apt install -y fonts-font-awesome
	printf "$CR polybar a été installée $CRS      \n"
	sleep 2
fi

# ROFI 
if [ "$choice" = "rofi" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de rofi $CRS \n"
	sleep 2
	cd $HOME && sudo apt install -y rofi
	mkdir ~/.config/rofi &&	cd $HOME/dotfiles
	stow -t ~/.config/rofi rofi
	printf "$CR rofi a été installée $CRS      \n"
	sleep 2
fi

# I3-CONFIG
if [ "$choice" = "i3-conf" ] || [ "$choice" = "5" ]; then
	printf "$CV Install fichiers de config I3 $CRS \n"
	sleep 2
	sudo apt install -y i3 rofi compton 
	mkdir $HOME/.config/i3
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/i3 i3
	printf "$CR les fichiers de config i3 ont été installés $CRS      \n"
	sleep 2
fi

# INSOMNIA
if [ "$choice" = "insomnia" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de insomnia $CRS \n"
	sleep 2
	cd $HOME && \
	echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
	sudo apt update && \
	sudo apt install -y insomnia && \
	sudo apt autoremove -y
	printf "$CR insomnia a été installée $CRS      \n"
	sleep 2
fi

# DBEAVER
if [ "$choice" = "dbeaver" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de dbeaver $CRS \n"
	sleep 2
	cd $HOME && \
	sudo add-apt-repository ppa:serge-rider/dbeaver-ce && \
	sudo apt update && sudo apt install -y dbeaver-ce
	printf "$CR dbeaver a été installée $CRS      \n"
	sleep 2
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de vscode $CRS \n"
	sleep 2
	cd $HOME && \
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install -y apt-transport-https
	sudo apt update && sudo apt install -y code
	printf "$CR vscode a été installée $CRS      \n"
	sleep 2
fi

# BTOP 
if [ "$choice" = "btop" ] || [ "$choice" = "5" ]; then
	printf "$CV Installation de btop $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt install -y btop
	printf "$CR btop a été installée $CRS      \n"
	sleep 2
fi

# ENDING 
if [ "$choice" = "5" ]; then
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE"
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE"
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE"
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE"
	sleep 2
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done

