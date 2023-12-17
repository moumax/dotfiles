# dotfiles

## START THE SCRIPT AND FOLLOW STEPS

### FOR WINDOWS WSL

#### Install wsl

- Open powershell in admin mod

```powershell
    wsl --list --online
```

```powershell
    wsl --install -d <Distribution Name>
```

#### Install choco softwares

- If chocolatey is not installed

```powershell
    Set-ExecutionPolicy AllSigned
```

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

- If chocolatey is installed

  - Open powershell in admin mod

For laptops

```powershell
    choco install vlc runjs dbeaver adobereader ocenaudio vscode insomnia-rest-api-client
```

For desktops

```powershell
    choco install nvidia-display-driver vlc runjs adobereader ocenaudio dbeaver vscode msiafterburner steam insomnia-rest-api-client
```

REBOOT THE MACHINE !!!

#### Install terminal preview edition

- Open windows store and find terminal preview
- Delete terminal in apps on windows

#### Install Iosevka font on windows

<https://github.com/moumax/dotfiles/raw/main/Iosevka.zip>

```sh
wget -P $HOME/ https://raw.githubusercontent.com/moumax/dotfiles/main/install_wsl.sh && \
chmod +x $HOME/install_wsl.sh
./install_wsl.sh
```

- Open windows_installation.md

### FOR ARCH LINUX

```sh
wget -P $HOME/ https://raw.githubusercontent.com/moumax/dotfiles/main/installArch.sh && \
chmod +x $HOME/installArch.sh
./installArch.sh
```

### FOR POP OS

```sh
wget -P $HOME/ https://raw.githubusercontent.com/moumax/dotfiles/main/install_pop.sh && \
chmod +x $HOME/install_pop.sh
./install_pop.sh
```

### ADD GIT KEY

[github key](https://github.com/settings/keys)

### ACTIVATE NVIM

```sh
cd .config/nvim/lua/marco
nvim packer.lua
```

=> :PackerUpdate
=> :q

```sh
nvim packer.lua
```

=> Let Neovim install all plugings

### ACTIVATE BLUETOOTH

```sh
sudo systemctl enable --now BLUETOOTH
sudo pacman -S blueman
```

### AFTER INSTALLING MARIADB

### There is no password for root

```sh
sudo mariadb-secure-installation
```

```sh
sudo mysql -u root -p
```

```mysql
CREATE USER 'marco'@'localhost' IDENTIFIED BY '******';
GRANT ALL PRIVILEGES ON *.* TO 'marco'@'localhost';
exit
```

=> Import a .sql file of a projet :
-   Create database in dbeaver

```bash
mysql -u username -p database_name < file.sql
```

### tmux

ctrl + h/j => switch between tmux windows
ctrl + s + up/down => to ajust splitted terminal on tmux

### SOME TIPS

To modify startups programs => /i3/conf To modify screen => /i3/conf

### USEFULL COMMANDS

xrandr => show all screens connected or not (usefull to give i3 apps on certain
screens) xprop => show the name of programs to put name on i3 file

### MYSQL2 TO MARIADB

Change collation :

```mysql
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

to

ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

Change all collate in database.sql

### GITUI BUG

When pushing is not working anymore :

```sh
eval `ssh-agent -s`
ssh-add ~/.ssh/id_ed25519
```
