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
	printf "  $CB wall $CRS      -- Installation du wallpaper \n"
	printf "  $CB stow $CRS      -- Install stow \n"
	printf "  $CB maj $CRS       -- Mise à jour système \n"
	printf "  $CB dep $CRS       -- Dépendances  \n"
	printf "  $CB folders $CRS   -- Préparation dossiers \n"
	printf "  $CB nvm $CRS       -- Install nvm \n"
	printf "  $CB node $CRS      -- Install nodeJs \n"
	printf "  $CB rust $CRS      -- Install rust \n"
	printf "  $CB gitdot $CRS    -- Install de l'env git \n"
	printf "  $CB nvchad $CRS    -- Install nvchad \n"
	printf "  $CB alacr $CRS     -- Install allacrity \n"
	printf "  $CB stars $CRS     -- Install de starship \n"
	printf "  $CB lazy $CRS      -- Install de lazygit \n"
	printf "  $CB tmux $CRS      -- Install de tmux \n"
	printf "  $CB insomnia $CRS  -- Install de insomnia \n"
	printf "  $CB dbeaver $CRS   -- Install de dbeaver \n"
	printf "  $CB vscode $CRS    -- Install de vscode \n"
	printf "  $CB sql $CRS       -- Install de mariadb \n"
	printf "  $CB btop $CRS      -- Install de btop \n"
	printf "  $CB mariadb $CRS   -- Install de mariadb \n"
	printf "  $CB oh $CRS        -- Install ohmyzsh \n"
	printf "  $CB ohfiles $CRS   -- Install fichiers ohmyzsh \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all   -- $CRS Full install \n"
	printf "  $CB chrome $CRS    -- Install de google chrome \n"
	printf "  $CR q     -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# WALLPAPER
if [ "$choice" = "wall" ] || [ "$choice" = "all" ]; then
  wget -P $HOME/downloads https://github.com/EndeavourOS-Community-Editions/Community-wallpapers/blob/main/eos_wallpapers_community/APOLLO-MOON.png
  cd $HOME/downloads/
 sudo mv APOLLO-MOON.png /usr/share/endeavouros/backgrounds/
fi

# STOW
if [ "$choice" = "stow" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "                  Installation de stow       \n"
	printf "  ================================================ $CRS\n"
  sleep 1 
  sudo pacman -S stow --noconfirm
fi

# MAJ 
if [ "$choice" = "maj" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "                 Mise à jour du système                 \n"
	printf "  ================================================ $CRS\n"
	sleep 1
  sudo pacman -Syyu
  yay -Syu
fi

# DEPENDANCES 
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "               Installation des dépendances           \n"
	printf "  ================================================ $CRS\n"
  sudo systemctl enable --now bluetooth
  sudo pacman -S blueman --noconfirm
  yay -S google-chrome --noconfirm
  yay -S picom --noconfirm
fi

# FOLDERS
if [ "$choice" = "folders" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "                Dossier /dev de travail           \n"
	printf "                 en cours de création           \n"
	printf "  ================================================ $CRS\n"
  sleep 1
	mkdir -p $HOME/dev 
fi

# NVM
if [ "$choice" = "nvm" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "           Installation de node version manager           \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	mkdir -p .nvm
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "              Installation de Rust & Cargo           \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	. $HOME/.cargo/env
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "       Installation des versions 16 et 18 de nodeJs    \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	. .nvm/nvm.sh
	nvm install 18 && nvm install 16 && nvm use 18
fi

# GITDOTFILES
if [ "$choice" = "gitdot" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "            Installation de la clé ssh git \n"
	printf "  ================================================ $CRS\n"
	sleep 1
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
  eval `ssh-agent -s`
	ssh-add $HOME/.ssh/id_ed25519
	printf "$CR Clé ssh à copier coller $CRS \n"
	cat $HOME/.ssh/id_ed25519.pub 
	printf "$CR Clé git crée $CRS      \n"
	sleep 1
	
	printf "$CV Récupération des dotfiles $CRS \n"
	sleep 1
	cd $HOME 
	printf "$CR Liens git clone ssh des dotfiles\n $CRS"
	read -p "Adresse de vos dotfiles " dotfiles
	printf " $CR Le dossier sera crée dans $HOME/dev/dotfiles $CRS\n"
	sleep 1

	if [ ! -d "$HOME/dev/dotfiles" ]; then
		printf "Le dossier de destination n'existe pas. Création du dossier..."
		mkdir -p "$HOME/dev/dotfiles"
	fi

	git clone "$dotfiles" "$HOME/dev/dotfiles"

	if [ $? -eq 0 ]; then
		printf "Le dépôt a été cloné avec succès dans $HOME/dotfiles \n"
		else
		printf "Une erreur s'est produite lors du clonage du dépôt. \n"
	fi
	printf " $CR ================================================\n"
	printf "      Copie des dotfiles dans les dossiers logiciels\n"
	printf "  ================================================ $CRS\n"
	sleep 1
  sudo rm -r $HOME/.config/i3
  mkdir $HOME/.config/i3
	cd $HOME/dotfiles
	stow -t $HOME/.config/i3 i3
	stow -t $HOME/.config/ picom
fi

# NVCHAD 
if [ "$choice" = "nvchad" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
	printf "        Installation des dépendances pour nvchad  \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S neovim --noconfirm
	printf " $CR ================================================\n"
	printf "            Installation de la font Iosevka  \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	wget -P $HOME/downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip && \
	cd $HOME/.local/share && \
	mkdir -p fonts && \
	cd fonts && \
	mv $HOME/downloads/Iosevka.zip . && \
	unzip Iosevka.zip
	printf " $CR ================================================\n"
	printf "                Installation de ripgrep \n"
	printf "  ================================================ $CRS\n"
  sleep 1
 	sudo pacman -S ripgrep --noconfirm
	printf " $CR ================================================\n"
  printf "                Suppression des fichiers nvim \n"
	printf "  ================================================ $CRS\n"
  sleep 1
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
	printf " $CR ================================================\n"
  printf "                   Installation de nvchad \n"
	printf "  ================================================ $CRS\n"
	git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                 Installation d'alacritty \n"
	printf "  ================================================ $CRS\n"
	sleep 1
  sudo pacman -S alacritty --noconfirm
	mkdir -p $HOME/.config/alacritty
	cd $HOME/dotfiles
	stow -t $HOME/.config/alacritty alacritty
fi

# STARSHIP
if [ "$choice" = "stars" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                Installation de starship \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S starship --noconfirm
	mkdir -p $HOME/.config/starship
	cd $HOME/dotfiles && \
	stow -t $HOME/.config/starship starship
fi

# LAZYGIT
if [ "$choice" = "lazy" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                Installation de lazygit \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S lazygit --noconfirm
fi

# TMUX 
if [ "$choice" = "tmux" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                  Installation de Tmux \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S tmux --noconfirm
	mkdir -p .tmux
	mkdir -p .tmux/tmux-powerline-custom-themes
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm && \
	git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.powerlinerc"
	wget -P $HOME/ "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux.conf"
	wget -P $HOME/.tmux/tmux-powerline-custom-themes "https://raw.githubusercontent.com/moumax/dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/marco-theme.sh"
	mv $HOME/.tmux/plugins/tmux-powerline/themes/default.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
	ln -s $HOME/.tmux/tmux-powerline-custom-themes/marco-theme.sh $HOME/.tmux/plugins/tmux-powerline/themes/default.sh
fi

# INSOMNIA
if [ "$choice" = "insomnia" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "               Installation de insomnia \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  yay -S insomnia-bin --noconfirm
fi

# DBEAVER
if [ "$choice" = "dbeaver" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                 Installation de dbeaver \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S dbeaver --noconfirm
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                Installation de vscode \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  yay -S visual-studio-code-bin --noconfirm
fi

# BTOP 
if [ "$choice" = "btop" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                Installation de btop \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME && \
  sudo pacman -S btop --noconfirm
fi

# MARIADB
if [ "$choice" = "sql" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "                Installation de mariadb \n"
	printf "  ================================================ $CRS\n"
	sleep 1
  sudo pacman -S mariadb --noconfirm
  mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# OHMYZSH 
if [ "$choice" = "oh" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "               Installation de Oh my Zsh  \n"
	printf "  ================================================ $CRS\n"
	sleep 1
  sudo pacman -S zsh --noconfirm
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# OHMYZSHFILES 
if [ "$choice" = "ohfiles" ] || [ "$choice" = "all" ]; then
	printf " $CR ================================================\n"
  printf "            Installation des plugins Oh my Zsh  \n"
	printf "  ================================================ $CRS\n"
	sleep 1
	cd $HOME
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	printf " $CR ================================================\n"
  printf "            Récupération du thème Oh my zsh \n"
	printf "  ================================================ $CRS\n"
  sleep 1
	cd $HOME/dotfiles
	sudo stow -t $HOME/.oh-my-zsh/custom/themes oh-my-zsh
	sudo rm $HOME/.zshrc && stow -t $HOME zsh
fi

# ENDING 
if [ "$choice" = "all" ]; then
	printf " n\ "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	printf "$CR PROCESS D'INSTALLATION TERMINE, REDEMARREZ LA MACHINE \n "
	sleep 3
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                Fin du script              \n"
	printf "  =========================================\n"
	exit 1
fi

done

