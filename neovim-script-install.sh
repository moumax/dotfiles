#!/bin/sh

# In this script, I use `printf` instead of `echo` to have a better compatibility w/ all shell.

set -e pipefail

Os="$(uname -s)"

if [ ! "$Os" = "Linux" ]; then
		printf "\n"
		printf "  ================================================\n"
		printf "                                                  \n"
		printf "                  Désolé ...                      \n"
		printf "                                                  \n"
		printf "       Script uniquement compatible Linux         \n"
		printf "                                                  \n"
		printf "  ================================================\n"
		exit 1
fi

if ! which node > /dev/null; then
		printf "\n"
		printf "  ================================================\n"
		printf "                                                  \n"
		printf "                    Désolé ...                    \n"
		printf "                                                  \n"
		printf "        Vous devez installer nodeJs en premier    \n"
		printf "                                                  \n"
		printf "  ================================================\n"
		exit 1
fi

printf "\n"
printf "  =========================================\n"
printf "                                           \n"
printf "      Bienvenue sur l'installeur Neovim    \n"
printf "                                           \n"
printf "  =========================================\n"

while true; do
	printf "\n"
	printf "  Quel est le nom de votre dossier ?\n"
	printf "  e.g.: 'neo-install' va créer ~/neo-install\n"
	printf "\n"
	printf "  Nom du dossier: "
	read FolderName

	if [ "$FolderName" = "" ]; then
		printf "\n"
		printf "  Vous devez écrire le nom du dossier\n"
		continue
	fi

	printf "\n"
	printf "  Cela va créer 3 dossiers: ~/%s, ~/%s/Apps and ~/%s/Dotfiles\n" "$FolderName" "$FolderName" "$FolderName"
	printf "  pour avoir cette structure de dossier\n\n"
	printf "  /home\n"
	printf "     │\n"
	printf "     └─ %s\n" "$USER"
	printf "        │\n"
	printf "        └─ %s\n" "$FolderName"
	printf "           │\n"
	printf "           └─ Apps\n"
	printf "           │   │\n"
	printf "           │   └─ Dossier d'installation de neovim\n"
	printf "           │\n"
	printf "           └─ Dotfiles\n"
	printf "               │\n"
	printf "               └─ Fichier de configuration de neovim\n"
	printf "\n"
	printf "  Continuer avec '%s' comme nom de dossier ?\n" "$FolderName"
	printf "\n"
	printf "  [y]es, [n]o or [q]uit: "
	read ChoiceFolderName

	case "$ChoiceFolderName" in
		y|yes|Y|YES|YEs|YeS|yeS|yES)
			break
			;;
		n|N|no|NO|No|nO)
			continue
			;;
		*)
			printf "\n"
			printf "  ================================================\n"
			printf "                                                  \n"
			printf "           Rien n'a été crée ou installé          \n"
			printf "                                                  \n"
			printf "                    A bientôt !                   \n"
			printf "                                                  \n"
			printf "  ================================================\n"
			exit 1
			;;
	esac
done

while true; do
	printf "\n"
	printf "  Merci d'écrire votre pseudo Neovim\n"
	printf "  e.g.: 'marco' will create ~/$FolderName/Dotfiles/Neovim/lua/marco\n"
	printf "\n"
	printf "  Pseudo neovim: "
	read NeovimUsername

	if [ "$NeovimUsername" = "" ]; then
		printf "\n"
		printf "  Vous devez rentrer votre pseudo pour configurer la config neovim\n"
		continue
	fi

	printf "\n"
	printf "  Cela va créer les dossiers suivants: ~/%s/Dotfiles/Neovim/lua/%s\n" "$FolderName" "$NeovimUsername"
	printf "  pour avoir cette structure de dossier\n\n"
	printf "  /home\n"
	printf "     │\n"
	printf "     └─ %s\n" "$USER"
	printf "        │\n"
	printf "        └─ %s\n" "$FolderName"
	printf "           │\n"
	printf "           └─ Apps\n"
	printf "           │   │\n"
	printf "           │   └─ Dossier d'installation de neovim\n"
	printf "           │\n"
	printf "           └─ Dotfiles\n"
	printf "              │\n"
	printf "              └─ neovim\n"
	printf "                 │\n"
	printf "                 └─ lua\n"
	printf "                 │   │\n"
	printf "                 │   └─ %s\n" "$NeovimUsername"
	printf "                 │      │\n"
	printf "                 │      └─ undodir/\n"
	printf "                 │      └─ keymaps.lua\n"
	printf "                 │      └─ options.lua\n"
	printf "                 │      └─ packer.lua\n"
	printf "                 │      └─ utils.lua\n"
	printf "                 │\n"
	printf "                 └─ after\n"
	printf "                     │\n"
	printf "                     └─ plugin\n"
	printf "                        │\n"
	printf "                        └─ plugin config file\n"
	printf "                        └─ plugin config file\n"
	printf "                        └─ ...\n"
	printf "                     │\n"
	printf "                     └─ ftplugin\n"
	printf "\n"
	printf "  Continuer avec '%s' comme pseudo neovim ?\n" "$NeovimUsername"
	printf "  [y]es, [n]o or [q]uit: "
	read ChoiceNeovimUsername

	case "$ChoiceNeovimUsername" in
		y|yes|Y|YES|YEs|YeS|yeS|yES)
			break
			;;
		n|N|no|NO|No|nO)
			continue
			;;
		*)
			printf "\n"
			printf "  ================================================\n"
			printf "                                                  \n"
			printf "           Rien n'a été crée ou installé          \n"
			printf "                                                  \n"
			printf "                    A bientôt                     \n"
			printf "                                                  \n"
			printf "  ================================================\n"
			exit 1
			;;
	esac
done

echo "\n"

BaseFolder="$HOME/$FolderName"
Apps="$HOME/$FolderName/Apps"
Dotfiles="$HOME/$FolderName/Dotfiles"

Neovim="$HOME/$FolderName/Dotfiles/neovim"
Lua="$HOME/$FolderName/Dotfiles/neovim/lua"
NeovimUserFolder="$HOME/$FolderName/Dotfiles/neovim/lua/$NeovimUsername"
Undodir="$HOME/$FolderName/Dotfiles/neovim/lua/$NeovimUsername/undodir"
After="$HOME/$FolderName/Dotfiles/neovim/after"
AfterPlugin="$HOME/$FolderName/Dotfiles/neovim/after/plugin"
AfterFtPlugin="$HOME/$FolderName/Dotfiles/neovim/after/ftplugin"
Plugin="$HOME/$FolderName/Dotfiles/neovim/plugin"

printf "======================================================\n"
printf "      Suppression des fichiers neovim suivants :      \n"
printf "         - fichiers d'installation                    \n"
printf "         - fichiers de configuration                  \n"
printf "======================================================\n"
rm -rf $HOME/.config/nvim
rm -rf $HOME/.local/share/nvim
rm -rf $Apps/Neovim
rm -rf $Dotfiles/neovim

if [ ! -d "$Apps" ]; then
	mkdir -p $Apps
	printf "=== %s crée ! ===\n" "$Apps"
fi

if [ ! -d "$dotfiles" ]; then
	mkdir -p $dotfiles
	printf "=== %s crée ! ===\n" "$dotfiles"
fi

if [ ! -d "$Neovim" ]; then
	mkdir -p $Neovim
	printf "=== %s crée  ! ===\n" "$Neovim"
	printf "\n"
	mkdir $Lua
	printf "=== %s crée ! ===\n" "$Lua"
	printf "\n"
	mkdir $NeovimUserFolder
	printf "=== %s crée ! ===\n" "$NeovimUserFolder"
	printf "\n"
	mkdir $Undodir
	printf "=== %s crée ! ===\n" "$Undodir"
	printf "\n"
	mkdir $After
	printf "=== %s crée ! ===\n" "$After"
	printf "\n"
	mkdir $AfterPlugin
	printf "=== %s crée ! ===\n" "$AfterPlugin"
	mkdir $AfterFtPlugin
	printf "=== %s crée ! ===\n" "$AfterFtPlugin"
	mkdir $Plugin
	printf "=== %s crée ! ===\n" "$Plugin"
fi

printf "\n"
printf "=== apt update ===\n"
printf "\n"
cd ~
sudo apt update
printf "=== apt upgrade ===\n"
printf "\n"
sudo apt upgrade -y

# Neovim install
printf "\n"
printf "==============================\n"
printf "    INSTALLATION DE NEOVIM    \n"
printf "==============================\n"
printf "\n"
printf "=== Installation des dépendances ===\n"
printf "\n"
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
cmake g++ pkg-config doxygen zoxide python3-pip mlocate libsqlite3-dev python3-dev \
libssl-dev ripgrep fd-find silversearcher-ag bat libicu-dev libboost-all-dev
sudo apt autoremove -y
printf "\n"
printf "=== git clone nvim-release-0.9 ===\n"
printf "\n"
cd $Apps
git clone -b release-0.9 https://github.com/neovim/neovim Neovim
cd Neovim
printf "=== make ===\n"
printf "\n"
make CMAKE_BUILD_TYPE=RelWithDebInfo
printf "\n"
printf "=== make install ===\n"
printf "\n"
sudo make install
printf "\n"
printf "==========================\n"
printf "    NEOVIM INSTALLE !     \n"
printf "==========================\n"
printf "\n"

# Pynvim
printf "\n"
printf "============================\n"
printf "    INSTALLATION DE PYNVIM  \n"
printf "============================\n"
printf "\n"
cd ~
pip3 install pynvim
printf "\n"
printf "==========================\n"
printf "    PYNVIM INSTALLE !     \n"
printf "==========================\n"
printf "\n"

# Packer
printf "\n"
printf "==============================\n"
printf "    INSTALLATION DE PACKER    \n"
printf "==============================\n"
printf "\n"
rm -rf ~/.local/share/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
printf "\n"
printf "==========================\n"
printf "    PACKER INSTALLE !     \n"
printf "==========================\n"
printf "\n"

# Tree-sitter-cli (node.js)
printf "\n"
printf "======================================\n"
printf "    INSTALLATION DE TREE-SITER-CLI    \n"
printf "             node.js                  \n"
printf "======================================\n"
printf "\n"
cd ~
npm i -g tree-sitter-cli
printf "\n"
printf "==================================\n"
printf "    TREE-SITER-CLI INSTALLE !     \n"
printf "==================================\n"
printf "\n"

# Neovim-cli (node.js)
printf "\n"
printf "==================================\n"
printf "    INSTALLATION DE NEOVIM-CLI    \n"
printf "            node.js               \n"
printf "==================================\n"
printf "\n"
cd ~
npm i -g neovim
printf "\n"
printf "==============================\n"
printf "    NEOVIM-CLI INSTALLE !     \n"
printf "==============================\n"
printf "\n"

# Neovim config
printf "\n"
printf "=====================\n"
printf "    NEOVIM CONFIG    \n"
printf "=====================\n"
printf "\n"
printf "=== installation fichiers de configuration ===\n"
printf "\n"
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/options.lua
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/keymaps.lua
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/utils.lua
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/packer.lua
wget -P $Neovim https://raw.githubusercontent.com/marco/dotfiles/main/neovim/init.lua
# Next two are not required: autorun and autosave
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/autorun.lua
wget -P $NeovimUserFolder https://raw.githubusercontent.com/marco/dotfiles/main/neovim/lua/marco/autosave.lua
printf "\n"
printf "=== Installation des fichiers de plugins ===\n"
printf "\n"
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/autopairs.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/colorscheme.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/colorful-winsep.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/comment.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/dashboard.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/gitsigns.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/glow.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/indent-blankline.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/lsp.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/lualine.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/luasnip.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/null-ls.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-autopairs.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-bqf.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-cmp.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-colorizer.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-notify.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-tree.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-treesitter.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/nvim-web-devicons.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/rust-tools.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/tailwindcss-colorizer-cmp.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/telescope.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/todo-comments.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/trouble.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/undotree.lua # Be careful with undotree, because I hardcode path inside this file !
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/vim-dadbod-ui.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/vim-illuminate.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/vimade.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/which-key.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/wilder.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/marco/dotfiles/main/neovim/after/plugin/winbar.lua
printf "\n"
printf "===============================\n"
printf "    NEOVIM CONFIG INSTALLE     \n"
printf "===============================\n"

# Stow
printf "\n"
printf "============================================\n"
printf "   LIENS SYMBOLIQUES VERS ~/.config/nvim    \n"
printf "============================================\n"
printf "\n"
cd $HOME/.config
mkdir nvim
cd $dotfiles
stow -t $HOME/.config/nvim neovim
printf "\n"
printf "=================================\n"
printf "    LIENS SYMBOLIQUES CREES !    \n"
printf "=================================\n"

# Neovim version
printf "\n"
printf "=== neovim version ===\n"
printf "\n"
nvim --version
