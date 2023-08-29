# dotfiles

```sh
wget -P ~/ https://raw.githubusercontent.com/moumax/dotfiles/main/install-script.sh && \
chmod +x ~/install-script.sh
```

## Install nvim

```sh
sudo apt install build-essential software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt install neovim -y
```

<br /><br /><br />


## Install dependencies

```sh
sudo apt update && \
sudo apt upgrade -y && \
sudo apt install -y git zsh zsh-syntax-highlighting curl i3 rofi compton \
tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
libssl-dev wget && \
sudo apt autoremove -y && \
sudo apt autoclean -y
```

<br /><br /><br />

## OH-MY-ZSH - install

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Close terminal.<br />
Logout then login.<br />
Open terminal.
<br /><br /><br />

## Install NVM

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
```

Close and re open terminal.

```sh
nvm install 18 && \
nvm install 16 && \
nvm use 18
```
Again, close and re open terminal.
<br /><br /><br />


## RUST - install

```sh
cd ~ && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

<br />
Close and re open terminal.
<br /><br /><br />

