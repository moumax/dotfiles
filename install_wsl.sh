!/bin/sh

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
	printf "  $CB dep $CRS       -- Install dépendences \n"
	printf "  $CB nvm $CRS       -- Install nvm \n"
	printf "  $CB rust $CRS      -- Install rust \n"
	printf "  $CB node $CRS      -- Install nodeJs \n"
	printf "  $CB folders $CRS   -- Préparation dossiers \n"
	printf "  $CB gitdot $CRS    -- Install de l'env git \n"
	printf "  $CB neovim $CRS    -- Install neovim \n"
	printf "  $CB font $CRS      -- Install Iosevka font \n"
	printf "  $CB stars $CRS     -- Install de starship \n"
	printf "  $CB fzf $CRS       -- Install de fzf \n"
	printf "  $CB glow $CRS      -- Install de glow \n"
	printf "  $CB tmux $CRS      -- Install de tmux \n"
	printf "  $CB oh $CRS        -- Install ohmyzsh \n"
	printf "  $CB ohfiles $CRS   -- Install fichiers ohmyzsh \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all   -- $CRS Full install \n"
	printf "  $CR q     -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# DEP
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des dependances $CRS \n"
	sleep 2
	sudo apt update && sudo apt upgrade -y && \
	sudo apt install -y git curl compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget vim zsh && \
	sudo apt autoremove -y && sudo apt autoclean -y
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# NVM
if [ "$choice" = "nvm" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de node version manager $CRS \n"
	sleep 2
	cd $HOME && \
	mkdir -p .nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	printf "$CR Installation de nvm terminé $CRS      \n"
	sleep 2
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Rust & Cargo $CRS \n"
	sleep 2
	cd $HOME
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	. $HOME/.cargo/env
	printf "$CR Installation de rust et Cargo terminés $CRS      \n"
	sleep 2
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des versions 16 et 18 de nodeJs $CRS \n"
	sleep 2
	. .nvm/nvm.sh
	nvm install 18 && nvm install 16 && nvm use 18
	printf "$CR Installation de NodeJs terminé $CRS      \n"
	sleep 2
fi

# FOLDERS
if [ "$choice" = "folders" ] || [ "$choice" = "all" ]; then
	printf " $CV Dossiers /dev en cours de création... \n"
	sleep 2
	mkdir -p $HOME/dev
	sleep 2
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# GITDOTFILES
if [ "$choice" = "gitdot" ] || [ "$choice" = "all" ]; then
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

	mkdir $HOME/.ssh && cd $HOME/.ssh
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
	printf " $CR Le dossier sera crée dans $HOME/dev/dotfiles $CRS\n"
	sleep 2

	if [ ! -d "$HOME/dev/dotfiles" ]; then
		printf "Le dossier de destination n'existe pas. Création du dossier... \n"
		mkdir -p "$HOME/dev/dotfiles"
	fi

	git clone "$dotfiles" "$HOME/dev/dotfiles"

	if [ $? -eq 0 ]; then
		printf "Le dépôt a été cloné avec succès dans $HOME/dev/dotfiles \n"
		else
		printf "Une erreur s'est produite lors du clonage du dépôt. \n"
	fi
	printf "$CR Dossier dotfiles récupéré et installé $CRS      \n"
	sleep 2
fi

# NEOVIM
if [ "$choice" = "neovim" ] || [ "$choice" = "all" ]; then
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
	cd $HOME/dev/dotfiles && stow -t $HOME/.config/nvim neovim
	printf "$CR Les dotfiles neovim ont été installés $CRS      \n"
	sleep 2
fi

# FONT
if [ "$choice" = "font" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de la font Iosevka $CRS \n"
	sleep 2
	wget -P $HOME/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip && \
	cd $HOME/.local/share && \
	mkdir -p fonts && cd fonts && mv $HOME/downloads/Iosevka.zip . && unzip Iosevka.zip
	printf "$CR La font Iosevka a été installé $CRS      \n"
	sleep 2
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de starship $CRS \n"
	sleep 2
	cd $HOME && \
	curl -sS https://starship.rs/install.sh | sh
	mkdir -p $HOME/.config/starship
	cd $HOME/dev/dotfiles && stow -t $HOME/.config/starship starship
	printf "$CR starship a été installé $CRS      \n"
	sleep 2
fi

# FZF
if [ "$choice" = "fzf" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de fzf $CRS \n"
	sleep 2
	cd $HOME && \
	git clone https://github.com/junegunn/fzf $HOME/.fzf && \
	cd $HOME/.fzf && ./install
	printf "$CR fzf a été installé $CRS      \n"
	sleep 2
fi

# GLOW
if [ "$choice" = "glow" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de glow $CRS \n"
	sleep 2
	sudo mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
	sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
	printf "$CR glow a été installé $CRS      \n"
	sleep 2
fi

# TMUX
if [ "$choice" = "tmux" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Tmux $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt remove tmux && sudo apt install -y libevent-dev ncurses-dev build-essential bison tmux
	sudo apt autoremove -y && sudo rm -rf .tmux
	cd $HOME && \
	mkdir -p .tmux && mkdir -p .tmux/tmux-powerline-custom-themes
	sudo apt install -y tmux
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm && \
	git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.powerlinerc"
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.conf"
	wget -P $HOME/.tmux/tmux-powerline-custom-themes "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/marco-theme.sh"
	mv $HOME/.tmux/plugins/tmux-powerline/themes/default.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
	ln -s $HOME/.tmux/tmux-powerline-custom-themes/marco-theme.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh
	printf "$CR Tmux a été installé $CRS      \n"
	sleep 2
fi

# OHMYZSH
if [ "$choice" = "oh" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Oh my Zsh $CRS \n"
	sleep 2
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# OHMYZSHFILES
if [ "$choice" = "ohfiles" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des plugins Oh my Zsh $CRS \n"
	sleep 2
	cd $HOME
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	printf "$CV Récupération du thème Oh my zsh $CRS \n"
	cd $HOME/dev/dotfiles
	sudo stow -t $HOME/.oh-my-zsh/custom/themes oh-my-zsh
	sudo rm $HOME/.zshrc && stow -t $HOME zsh
	sleep 2
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# ENDING
if [ "$choice" = "all" ]; then
	printf " n\ "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	sleep 2
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done
