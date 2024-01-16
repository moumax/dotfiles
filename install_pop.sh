!/bin/sh

set -e pipefail
os="$(uname -s)"

COLOR_RESET='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_BLUE='\033[0;34m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_CYAN='\033[0;36m'
COLOR_WHITE='\033[0;37m'

# Variables de dossiers
neovim_configuration_directory="$HOME/.config/nvim"
plugins_nvim_configuration_directory="$HOME/.local/share/nvim"
nvm_directory="$HOME/.nvm"
font_directory="$HOME/.local/share/fonts"
dev_directory="$HOME/dev"
ssh_directory="/.ssh"
dotfiles_directory="$HOME/dotfiles"
alacritty_configuration_directory="$HOME/.config/alacritty"
keyring_directory="/etc/apt/keyrings"
gnupg_directory="/root/gnupg"
gnupg_crls_directory="/root/gnupg_crls"
gnupg_cache_file="/root/gnupg_cache"

# Function to create a display install message
display_install() {
    printf "================================================\n"
    printf "================================================\n"
    printf "        ${COLOR_YELLOW}$1${COLOR_RESET}         \n"
    printf "================================================\n"
    printf "================================================\n"
}

# Function to create a display for state message
display_status() {
    echo "${COLOR_YELLOW}$1${COLOR_RESET}"
}

# Function to create a display error message
display_error() {
    echo "${COLOR_RED}Error: $1${COLOR_RESET}"
    exit 1
}

# Function to create a display information message
display_info() {
    echo "${COLOR_CYAN}$1${COLOR_RESET}"
}

# Function to create a display success message 
display_success() {
    echo "${COLOR_GREEN}$1${COLOR_RESET}"
}

# Function to create a directory if he doesn't exist
create_directory() {
    if [ ! -d "$1" ]; then
        sudo mkdir -p "$1"
        if [ $? -eq 0 ]; then
          display_success "Folder $1 successfully created"
        else
          display_error "Error creating directory $1"
        fi
    else
        display_status "Folder $1 already exists"
    fi
}

if [ ! "$os" = "Linux" ]; then
	printf "\n"
	printf "  ================================================\n"
	printf "        This script is only usable on Linux Os    \n"
	printf "  ================================================\n"
	exit 1
fi

while true; do

	printf "\n"
	printf "  =============================================\n"
	printf " $COLOR_YELLOW       Installation script for Pop-Os\n"
	printf "             by Moumax (v2.00) $COLOR_RESET    \n"
	printf "  =============================================\n"
	printf "\n"
	printf "\n"
	printf "  $COLOR_GREEN update $COLOR_RESET    -- Update for distro and softwares \n"
	printf "\n"
	printf "\n"
	printf "  $COLOR_BLUE dep $COLOR_RESET       -- Dependancies installation \n"
	printf "  $COLOR_BLUE clean $COLOR_RESET     -- Pop-Os cleaning distro \n"
	printf "  $COLOR_BLUE nvm $COLOR_RESET       -- Node Version Manager installation \n"
	printf "  $COLOR_BLUE rust $COLOR_RESET      -- Rust installation \n"
	printf "  $COLOR_BLUE node $COLOR_RESET      -- NodeJs installation \n"
	printf "  $COLOR_BLUE folders $COLOR_RESET   -- Dev folder creation \n"
	printf "  $COLOR_BLUE git $COLOR_RESET       -- Git environement installation \n"
	printf "  $COLOR_BLUE bob $COLOR_RESET       -- Bob installation for Neovim \n"
	printf "  $COLOR_BLUE font $COLOR_RESET      -- Iosevka font installation \n"
	printf "  $COLOR_BLUE alac $COLOR_RESET      -- Allacrity installation \n"
	printf "  $COLOR_BLUE lazy $COLOR_RESET      -- Lazygit installation \n"
	printf "\n"
	printf "\n"
	printf "OPTIONAL SOFTWARES \n"
	printf "\n"
	printf "\n"
	printf "  $COLOR_YELLOW vlc $COLOR_RESET       -- Vlc installation \n"
	printf "  $COLOR_YELLOW dbeaver $COLOR_RESET   -- Dbeaver installation \n"
	printf "  $COLOR_YELLOW vscode $COLOR_RESET    -- Vscode installation \n"
	printf "  $COLOR_YELLOW bruno $COLOR_RESET     -- Bruno installation \n"
	printf "  $COLOR_YELLOW btop $COLOR_RESET      -- Btop installation \n"
	printf "  $COLOR_YELLOW mariadb $COLOR_RESET   -- Mariadb installation \n"
	printf "\n"
	printf "  ---------------------------------------------\n"
	printf "  $COLOR_GREEN all   -- $COLOR_RESET Full install \n"
	printf "  $COLOR_RED q     -- $COLOR_RESET Quit            \n"
	printf "\n"

	read -p "Type your choice ? " choice

# UPDATE
if [ "$choice" = "update" ]; then
    display_install "Updating system and software"
    sleep 2

    # Package updates
    sudo apt update
    if [ $? -eq 0 ]; then
        display_status "Package repository updated successfully"
    else
        display_error "Error updating package repository"
    fi

    # Package upgrade
    sudo apt upgrade -y
    if [ $? -eq 0 ]; then
        display_status "Packages upgraded successfully"
    else
        display_error "Error upgrading packages"
    fi

    # Deleting obsolete packages
    sudo apt autoremove -y
    if [ $? -eq 0 ]; then
        display_status "Obsolete packages removed successfully"
    else
        display_error "Error removing obsolete packages"
    fi

    # Unused files cleanup
    sudo apt autoclean -y
    if [ $? -eq 0 ]; then
        display_status "Unused files cleaned successfully"
    else
        display_error "Error cleaning unused files"
    fi

    display_success "Operations successfully terminated"
    sleep 2
fi

# DEP
if [ "$choice" = "dep" ] || [ "$choice" = "all" ]; then
    display_install "Installing Dependencies"
    sleep 2

    # Dependancies installation
    sudo apt install -y stow git curl compton \
        tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
        neofetch mlocate zoxide python3-pip libsqlite3-dev \
        libssl-dev wget vim zsh
    if [ $? -eq 0 ]; then
        display_success "Dependencies installed successfully"
    else
        display_error "Error installing dependencies"
    fi

    # Deleting obsolete packages
    sudo apt autoremove -y
    if [ $? -eq 0 ]; then
        display_status "Obsolete packages removed successfully"
    else
        display_error "Error removing obsolete packages"
    fi

    # Unused files cleanup
    sudo apt autoclean -y
    if [ $? -eq 0 ]; then
        display_status "Unused files cleaned successfully"
    else
        display_error "Error cleaning unused files"
    fi

    display_success "Operations successfully terminated"
    sleep 2
fi

# CLEAN
if [ "$choice" = "clean" ] || [ "$choice" = "all" ]; then
    display_status "Cleaning distribution..."
    sleep 2

    # Package deletion
    sudo apt remove -y libreoffice-base-core libreoffice-common libreoffice-core \
        libreoffice-style-colibre libreoffice-style-elementary \
        libreoffice-style-yaru geary
    if [ $? -eq 0 ]; then
        display_success "Packages removed successfully"
    else
        display_error "Error removing packages"
    fi

    display_success "Cleaning was successfully terminated"
    sleep 2
fi

# NVM
if [ "$choice" = "nvm" ] || [ "$choice" = "all" ]; then
    display_status "Node Version Manager installation"
    sleep 2

    create_directory "$nvm_directory"

    # Download and execution of nvm script
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # Installation check
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        display_success "Node Version Manager was successfully installed"
    else
        display_error "Error installing Node Version Manager"
    fi

    sleep 2
fi

# RUST
if [ "$choice" = "rust" ] || [ "$choice" = "all" ]; then
    display_status "Rust & Cargo installation"
    sleep 2

    cd $HOME
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    . $HOME/.cargo/env

    # Rust installation check
    if command -v rustc &>/dev/null && command -v cargo &>/dev/null; then
        display_success "Rust & Cargo were successfully installed"
    else
        display_error "Error installing Rust & Cargo"
    fi

    sleep 2
fi

# NODE
if [ "$choice" = "node" ] || [ "$choice" = "all" ]; then
    display_status "NodeJs 16 & 18 installation"
    sleep 2

    # NVM disponibility
    if command -v nvm &>/dev/null; then
        . .nvm/nvm.sh

        # Node 16 & 18 installation and node 18 by default
        nvm install 18 && nvm install 16 && nvm use 18

        # NodeJs check
        if command -v node &>/dev/null && command -v npm &>/dev/null; then
            display_success "NodeJs 16 & 18 were successfully installed"
        else
            display_error "Error installing NodeJs 16 & 18"
        fi
    else
        display_status "NVM is not installed. Please install NVM first."
        exit 1
    fi

    sleep 2
fi

# FOLDERS
if [ "$choice" = "folders" ] || [ "$choice" = "all" ]; then
    if [ -d "$dev_directory" ]; then
        display_status "dev folder already exists !!!"
    else
        cd $HOME && \
        create_directory "$dev_directory" && cd $dev_directory

        # Dev folder creation check
        if [ -d "$dev_directory" ]; then
            display_success "dev folder was successfully created"
        else
            display_error "Error creating dev folder"
        fi
    fi

    display_success "Operations successfully terminated"
    sleep 2
fi

# GITDOTFILES
if [ "$choice" = "gitdot" ] || [ "$choice" = "all" ]; then
    display_status "Git key installation process"
    sleep 2

    # Asking name and email for github
    read -p "$CJ Your email address? : $CRS" EmailGit
    if [ -z "$EmailGit" ]; then
        printf "\n"
        display_error "You must provide a valid email address\n"
    fi

    read -p "Your name on GitHub? : " NameGit
    if [ -z "$NameGit" ]; then
        printf "\n"
        display_error "You must provide a valid name\n"
    fi

    # Global configuration for git
    git config --global user.name "$NameGit" && \
    display_success "git config --global user.name \"$NameGit\"\n"
    git config --global user.email "$EmailGit" && \
    display_success "git config --global user.email \"$EmailGit\"\n"
    git config --global init.defaultBranch main && \
    display_success "git config --global init.defaultBranch main\n"

    # .ssh folder creation if not exist
    create_directory "$ssh_directory"
    cd $ssh_directory

    # Ssh key creation
    ssh-keygen -t ed25519 -C "$EmailGit"

    # Start of ssh agent and private key adding
    eval "$(ssh-agent -s)"
    ssh-add $HOME/.ssh/id_ed25519
    display_status "Copy and paste this key into GitHub\n"
    cat $HOME/.ssh/id_ed25519.pub
    display_success "Key successfully created\n"
    sleep 2

    display_status "Dotfiles retrieval\n"
    sleep 2
    cd $HOME

    # Asking dotfiles link
    display_status "Link to your dotfiles\n"
    read -p "Please enter the link to your dotfiles: " dotfiles

    # Dotfile folder creation if doesn't exist
    create_directory "$dotfiles_directory"

    display_status "Cloning your dotfiles...\n"
    git clone "$dotfiles" "$dotfiles_directory"

    if [ $? -eq 0 ]; then
        display_success "Repo successfully created in $dotfiles_directory"
        display_success "Operation completed successfully"
    else
        display_error "There was an error when cloning your dotfiles"
    fi
    sleep 2
fi

# BOB FOR NVIM
if [ "$choice" = "bob" ] || [ "$choice" = "all" ]; then
    display_status "Bob installation for Neovim"
    sleep 2

    # Bob installation for Neovim
    cargo install bob-nvim
    bob install stable

    display_status "Neovim dotfile installation"
    sleep 2

    # Delete Neovim configuration folder if doesn't exist
    if [ -d "$neovim_configuration_directory" ]; then
        sudo rm -rf "$neovim_configuration_directory"
        display_success "Folder $neovim_configuration_directory deleted successfully."
    else
        display_status "Folder $neovim_configuration_directory doesn't exist, no further actions needed."
    fi

    # Neovim plugins folder deletion if exist
    if [ -d "$plugins_nvim_configuration_directory" ]; then
        sudo rm -rf "$plugins_nvim_configuration_directory"
        display_success "Folder $plugins_nvim_configuration_directory deleted successfully."
    else
        display_status "Folder $plugins_nvim_configuration_directory doesn't exist, no further actions needed."
    fi

    # Neovim configuration folder
    create_directory "$neovim_configuration_directory"

    # Clone Neovim dotfiles
    git clone git@github.com:moumax/neovim-2024.git "$neovim_configuration_directory"

    display_success "Neovim dotfiles successfully installed"
    sleep 2
fi

# FONT
if [ "$choice" = "font" ] || [ "$choice" = "all" ]; then
    display_status "Iosevka Font installation"
    sleep 2

    # Font folder creation if doesn't exist
    create_directory "$font_directory"

    # Download and extraction of the font
    cd "$font_directory" && \
    wget https://github.com/moumax/dotfiles/raw/main/Iosevka.zip && \
    unzip Iosevka.zip && \
    sudo rm -r Iosevka.zip

    display_success "Iosevka Font successfully installed"
    sleep 2
fi

# ALACRITTY
if [ "$choice" = "alacr" ] || [ "$choice" = "all" ]; then
    display_status "Alacritty installation"
    sleep 2

    # Adding PPA for Alacritty
    sudo add-apt-repository ppa:aslatter/ppa -y

    # Update and install Alacritty
    sudo apt update
    sudo apt install -y alacritty

    # Alacritty configuration folder creation if doesn't exist
    create_directory "$alacritty_configuration_directory"

    cd "$HOME/dev/dotfiles"

    # Stow configuration file on good folder
    stow -t $alacritty_configuration_directory alacritty

    display_success "Alacritty successfully installed"
    sleep 2
fi

# LAZYGIT
if [ "$choice" = "lazy" ] || [ "$choice" = "all" ]; then
    display_status "Lazygit installation"
    sleep 2

    cd "$HOME"

    # Last version of Lazygit
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

    # Download Lazygit archive
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    # Extract Lazygit archive 
    tar xf lazygit.tar.gz lazygit

    # Install Lazygit in /usr/local/bin
    sudo install lazygit /usr/local/bin

    # Lazygit installation file deletion
    rm lazygit.tar.gz

    display_success "Lazygit successfully installed"
    sleep 2
fi

# VLC
if [ "$choice" = "vlc" ]; then
    display_status "VLC installation"
    sleep 2

    cd "$HOME"

    sudo apt install -y vlc

    display_success "VLC successfully installed"
    sleep 2
fi

# DBEAVER
if [ "$choice" = "dbeaver" ]; then
    display_status "DBeaver installation"
    sleep 2

    cd "$HOME"

    sudo add-apt-repository ppa:serge-rider/dbeaver-ce

    sudo apt update && sudo apt install -y dbeaver-ce

    display_success "DBeaver successfully installed"
    sleep 2
fi

# VSCODE
if [ "$choice" = "vscode" ] || [ "$choice" = "all" ]; then
    display_status "Visual Studio Code installation"
    sleep 2

    cd "$HOME"

    # Download of the signature key
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

    # Installing key in system
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt install -y apt-transport-https && sudo apt update && sudo apt install -y code

    display_success "Visual Studio Code was successfully installed"
    sleep 2
fi

# BRUNO
if [ "$choice" = "bruno" ] || [ "$choice" = "all" ]; then
  display_status "Bruno installation"
  sleep 2

  # Folders creation
  create_directory "$keyring_directory"
  create_directory "$gnupg_directory"
  create_directory "$gnupg_crls_directory"

  # Cache file creation
  if [ ! -e "$gnupg_cache_file" ]; then
      sudo touch "$gnupg_cache_file"
      display_success "Cache file $gnupg_cache_file was created successfully"
  else
      display_status "Cache file $gnupg_cache_file exists. No action needed"
  fi

  # Gpg key retrieval
  sudo gpg --no-default-keyring --keyring "$keyring_directory/bruno.gpg" --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266

  # Configuration des sources et installation de Bruno
  echo "deb [signed-by=$keyring_directory/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list
  sudo apt update
  sudo apt install bruno
  display_success "Bruno was successfully installed"
  sleep 2
fi

# BTOP
if [ "$choice" = "btop" ] || [ "$choice" = "all" ]; then
    display_status "Btop installation"
    sleep 2

    cd "$HOME"

    sudo apt install -y btop

    display_success "Btop was successfully installed"
    sleep 2
fi

# MARIADB
if [ "$choice" = "mariadb" ] || [ "$choice" = "all" ]; then
    display_status "Mariadb installation"
    sleep 2

    sudo apt update && sudo apt install mariadb-server

    display_success "Mariadb was successfully installed"
    sleep 2
fi

# ENDING
if [ "$choice" = "all" ]; then
	printf " n\ "
	printf "$CV INSTALLATION PROCESS IS NOW OVER, PLEASE REBOOT THE COMPUTER  \n "
	printf "$CV INSTALLATION PROCESS IS NOW OVER, PLEASE REBOOT THE COMPUTER  \n "
	printf "$CV INSTALLATION PROCESS IS NOW OVER, PLEASE REBOOT THE COMPUTER  \n "
	printf "$CV INSTALLATION PROCESS IS NOW OVER, PLEASE REBOOT THE COMPUTER  \n "
	sleep 2
fi

if [ "$choice" = "q" ]; then
	printf "  =========================================\n"
	printf "                End of script, bye !       \n"
	printf "  =========================================\n"
	exit 1
fi

done
