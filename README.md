# dotfiles

## START THE SCRIPT AND FOLLOW STEPS

```sh
wget -P $HOME/ https://raw.githubusercontent.com/moumax/dotfiles/main/installArch.sh && \
chmod +x $HOME/installArch.sh
./installArch.sh
```

## ADD GIT KEY

[github key](https://github.com/settings/keys)

## ACTIVATE BLUETOOTH

```sh
sudo systemctl enable --now BLUETOOTH
sudo pacman -S blueman
```

## INSTALL MARIADB

```sh
sudo mariadb-secure-installation

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sudo systemctl stop mariadb
sudo mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
```

```mysql
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new_password');
```

Restart computer

```sh
sudo mysql_secure_installation
```

```sh
mysql -h 127.0.0.1 -P 3306 -u root -p
```

```mysql
CREATE USER 'marco'@'localhost' IDENTIFIED BY '******';
GRANT ALL PRIVILEGES ON *.* TO 'marco'@'localhost';
exit
```

## SOME KEYBINDINGS

win+f => thunar <br /> ctrl + h/j => switch between tmux windows

## SOME TIPS

To modify startups programs => /i3/conf To modify screen => /i3/conf

## USEFULL COMMANDS

xrandr => show all screens connected or not (usefull to give i3 apps on certain
screens) xprop => show the name of programs to put name on i3 file

## MYSQL2 TO MARIADB
Change collation : 

```mysql
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

to

ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

Change all collate in database.sql

## GITUI BUG
When pushing is not working anymore :

```sh
eval `ssh-agent -s`
ssh-add ~/.ssh/id_ed25519
```

<br /><br /><br />
