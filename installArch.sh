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
	printf "  $CB maj $CRS       -- Mise à jour système \n"
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
	printf "  $CB gitui $CRS     -- Install de gitui \n"
	printf "  $CB chrome $CRS    -- Install de google chrome \n"
	printf "  $CB tmux $CRS      -- Install de tmux \n"
	printf "  $CB insomnia $CRS  -- Install de insomnia \n"
	printf "  $CB dbeaver $CRS   -- Install de dbeaver \n"
	printf "  $CB mariadb $CRS    -- Install de vscode \n"
	printf "  $CB btop $CRS      -- Install de btop \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all   -- $CRS Full install \n"
	printf "  $CB 0     -- $CRS Première phase d'installation \n"
	printf "  $CB 1     -- $CRS Seconde phase d'installation \n"
	printf "  $CR q     -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# DEP
if [ "$choice" = "maj" ] || [ "$choice" = "0" ] || [ "$choice" = "all" ]; then
	printf "$CV Mise à jour du système $CRS \n"
	sleep 2
	printf "$CV Mise à jour pacman $CRS \n"
  sleep 2
  sudo pacman -Syyu
	printf "$CV Mise à jour yay $CRS \n"
  sleep 2
  yay -Syu
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# CHROME
if [ "$choice" = "chrome" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Google Chrome $CRS \n"
	sleep 2
  yay -S google-chrome
	printf "$CR Google Chrome a été installée $CRS      \n"
	sleep 2
fi

# NVM
if [ "$choice" = "nvm" ] || [ "$choice" = "0" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de node version manager $CRS \n"
	sleep 2
	cd $HOME && \
	mkdir -p .nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	printf "$CR Installation de nvm terminé $CRS      \n"
	sleep 2
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "0" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Rust & Cargo $CRS \n"
	sleep 2
	cd $HOME
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	. $HOME/.cargo/env
	printf "$CR Installation de rust et Cargo terminés $CRS      \n"
	sleep 2
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des versions 16 et 18 de nodeJs $CRS \n"
	sleep 2
	. .nvm/nvm.sh
	nvm install 18 && nvm install 16 && nvm use 18
	zenity --info --text="Fermez le terminal\n Reouvrir le terminal" --width=$dialog_width --height=$dialog_height
	printf "$CR Installation de NodeJs terminé $CRS      \n"
	sleep 2
fi

# FOLDERS
if [ "$choice" = "folders" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Dossiers /dev de travail $CRS \n"
	printf "$CV en cours de création...$CRS \n"
  sleep 2
	mkdir -p $HOME/dev 
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# GITDOTFILES
if [ "$choice" = "gitdot" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
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

# NVCHAD 
if [ "$choice" = "nvchad" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des dépendances pour nvchad $CRS \n"
	sleep 2
	cd $HOME && \
  sudo pacman -S neovim
	printf "$CR Neovim est installé $CRS \n"
  sleep 2
	printf "$CV Installation de la font Iosevka $CRS \n"
	sleep 2
	wget -P $HOME/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip && \
	cd $HOME/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv $HOME/downloads/Iosevka.zip . && \
	unzip Iosevka.zip
	printf "$CR La font Iosevka a été installée $CRS      \n"
	sleep 2
	printf "$CV Installation de ripgrep $CRS \n"
  sleep 2
  sudo pacman -S ripgrep
	printf "$CR ripgrep a été installé $CRS      \n"
  sleep 2
	printf "$CV Suppression des fichiers nvim $CRS \n"
  sleep 2
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvimV
	printf "$CR Les fichiers nvim ont été supprimés $CRS      \n"
  sleep 2
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation d'alacritty $CRS \n"
	sleep 2
  sudo pacman -S alacritty
	mkdir -p $HOME/.config/alacritty
	cd $HOME/dotfiles
	stow -t $HOME/.config/alacritty alacritty
	printf "$CR alacritty a été installée $CRS      \n"
	sleep 2
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
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

# GITUI
if [ "$choice" = "gitui" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de gitui $CRS \n"
	sleep 2
	cd $HOME && \
  sudo pacman -S gitui
	mkdir $HOME/.config/gitui && \
	cd $HOME/dotfiles
	stow -t $HOME/.config/gitui gitui
	printf "$CR gitui a été installée $CRS      \n"
	sleep 2
fi

# TMUX 
if [ "$choice" = "tmux" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
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

# INSOMNIA
if [ "$choice" = "insomnia" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de insomnia $CRS \n"
	sleep 2
	cd $HOME && \
  yay -S insomnia-bin
	printf "$CR insomnia a été installée $CRS      \n"
	sleep 2
fi

# DBEAVER
if [ "$choice" = "dbeaver" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de dbeaver $CRS \n"
	sleep 2
	cd $HOME && \
  sudo pacman -S dbeaver
	printf "$CR dbeaver a été installée $CRS      \n"
	sleep 2
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de vscode $CRS \n"
	sleep 2
	cd $HOME && \
  yay -S visual-studio-code-bin
	printf "$CR vscode a été installée $CRS      \n"
	sleep 2
fi

# BTOP 
if [ "$choice" = "btop" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de btop $CRS \n"
	sleep 2
	cd $HOME && \
  sudo pacman -S btop
	printf "$CR btop a été installée $CRS      \n"
	sleep 2
fi

# MARIADB
if [ "$choice" = "sql" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de mariadb $CRS \n"
	sleep 2
  sudo pacman -S mariadb
	printf "$CR mariadb a été installée $CRS      \n"
	sleep 2
fi

# OHMYZSH 
if [ "$choice" = "oh" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Oh my Zsh $CRS \n"
	sleep 2
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	printf "$CV Installation de Oh my Zsh effectué $CRS \n"
  sleep 2
fi

# OHMYZSHFILES 
if [ "$choice" = "ohfiles" ] || [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
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
fi

# ENDING 
if [ "$choice" = "1" ] || [ "$choice" = "all" ]; then
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

