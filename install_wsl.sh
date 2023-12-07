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
	printf "  $CV update $CRS    -- Mise à jour de la distribution et des paquets \n"
	printf "\n"
	printf "\n"
	printf "  $CB prep $CRS      -- Préparation de windows \n"
	printf "  $CB dep $CRS       -- Installation des dépendences obligatoires \n"
	printf "  $CB nvm $CRS       -- Installation de nvm \n"
	printf "  $CB rust $CRS      -- Installation de rust \n"
	printf "  $CB node $CRS      -- Installation de nodeJs \n"
	printf "  $CB folders $CRS   -- Création d'un dossier dev à la racine \n"
	printf "  $CB gitdot $CRS    -- Installation de l'environnement git \n"
	printf "  $CB neovim $CRS    -- Installation de neovim \n"
	printf "  $CB stars $CRS     -- Installation de starship \n"
	printf "  $CB lazy $CRS      -- Installation de lazygit\n"
	printf "  $CB tmux $CRS      -- Installation de tmux \n"
	printf "  $CB mariadb $CRS   -- Installation de mariadb \n"
	printf "  $CB oh $CRS        -- Installation ohmyzsh \n"
	printf "  $CB ohfiles $CRS   -- Installation des fichiers ohmyzsh \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $CB all   -- $CRS Full install \n"
	printf "  $CR q     -- $CRS Quitter le script             \n"
	printf "\n"

	read -p "Votre choix ? " choice

# UPDATE
if [ "$choice" = "update" ]; then
	printf "$CV Mise à jour du système et des logiciels $CRS \n"
	sleep 2
	sudo apt update && sudo apt upgrade -y && \
	sudo apt autoremove -y && sudo apt autoclean -y
	printf "$CR Opérations terminées $CRS      \n"
	sleep 2
fi

# PREP
if [ "$choice" = "prep" ] || [ "$choice" = "all" ]; then
    printf "$CV Préparation de windows $CRS \n"
	printf " \n"
    printf "$CV Suivez les instructions $CRS \n"
    sleep 2

    while true; do
        printf "  $CB INSTALLATION DE WSL $CRS \n"
		printf " \n"
        printf "  $CV Lancez powershell en mode administrateur $CRS \n"
		printf " \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    while true; do
        printf "  $CB POUR LISTER LES DISTRIBUTIONS WSL :$CRS \n"
		printf " \n"
        printf "  $CV wsl --list --online $CRS \n"
		printf " \n"
        printf "  $CB POUR INSTALLER WSL :$CRS \n"
		printf " \n"
        printf "  $CV wsl --install -d Ubuntu-22.04 $CRS \n"
		printf " \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    while true; do
        printf "  $CB POUR INSTALLER LES APPLICATIONS CHOCOLATEY :$CRS \n"
		printf " \n"
		printf " $CB Si chocolatey n'est pas installé => $CRS\n"
		printf " \n"
		printf " $CV Set-ExecutionPolicy AllSigned $CRS\n"
		printf " $CV Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) $CRS\n"
		printf " \n"
		printf " $CB Si chocolatey est déjà installé => $CRS\n"
		printf " \n"
        printf "  $CV choco install nvidia-display-driver vlc runjs adobereader ocenaudio dbeaver vscode msiafterburner steam vivaldi $CRS \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    while true; do
        printf "  $CB POUR AUGMENTER LA VITESSE DE FRAPPE DU CLAVIER :$CRS \n"
		printf " \n"
        printf "  $CV Se rendre dans le registre windows (regedit) $CRS \n"
		printf " \n"
        printf "  $CV Allez sur ce lien : HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response $CRS \n"
		printf " \n"
        printf "  $CV Modifier les valeurs suivantes : $CRS \n"
		printf " \n"
        printf "  $CV AutoRepeatDelay = 200 $CRS \n"
        printf "  $CV AutoRepeatRate= 9 $CRS \n"
        printf "  $CV DelayBeforeAcceptance = 0 $CRS \n"
        printf "  $CV flags = 59 $CRS \n"
		printf " \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    while true; do
        printf "  $CB INSTALLATION DE LA FONT IOSEVKA :$CRS \n"
		printf " \n"
        printf "  $CV Téléchargez ce fichier : $CRS \n"
		printf " \n"
        printf "  $CV https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IosevkaTerm.zip $CRS \n"
		printf " \n"
        printf "  $CV Décompressez toutes les polices $CRS \n"
		printf " \n"
        printf "  $CV Les installer en cliquant droit $CRS \n"
		printf " \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    while true; do
        printf "  $CB INSTALLATION DU TERMINAL WINDOWS :$CRS \n"
		printf " \n"
        printf "  $CV Dans le windows store, téléchargez la version preview du terminal $CRS \n"
		printf " \n"
        printf "  $CV Pensez à mettre l'opacité sur 80% et à régler la police sur Iosevka en semi light $CRS \n"
		printf " \n"
        read -p "Passer à l'étape suivante ? (Appuyez sur y/Y pour continuer, n/N pour annuler) " confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            break
        elif [ "$confirm" = "n" ] || ["$confirm" = "N"]; then
            printf "$CR Opérations annulées $CRS \n"
            exit 1
        else
            printf "$CR Choix non valide. Veuillez répondre avec 'y/Y' ou 'n/N' $CRS \n"
        fi
    done

    printf "$CR Opérations terminées $CRS      \n"
    sleep 2
fi

# DEP
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation des dependances $CRS \n"
	sleep 2
	sudo apt update && sudo apt upgrade -y && \
	sudo apt install git curl compton \
	tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
	neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
	libssl-dev wget vim zsh -y && \
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
	cd $HOME
	mkdir .config
	cd $HOME/.config
	mkdir nvim
	cd $HOME/dev/dotfiles && stow -t $HOME/.config/nvim neovim
	printf "$CR Les dotfiles neovim ont été installés $CRS      \n"
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

# LAZYGIT
if [ "$choice" = "lazy" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Lazygit $CRS \n"
	sleep 2
	cd $HOME && \
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
	tar xf lazygit.tar.gz lazygit && \
	sudo install lazygit /usr/local/bin && \
	printf "$CR Lazygit a été installé $CRS      \n"
	sleep 2
fi

# TMUX
if [ "$choice" = "tmux" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de Tmux $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt remove tmux && sudo apt install libevent-dev ncurses-dev build-essential bison tmux -y
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

# MARIADB
if [ "$choice" = "mariadb" ] || [ "$choice" = "all" ]; then
	printf "$CV Installation de MariaDB $CRS \n"
	sleep 2
	cd $HOME && \
	sudo apt install mariadb-server -y
	printf "$CR MariaDB a été installé $CRS      \n"
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
	cd $HOME/dev/dotfiles/wsl-dotfiles
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
