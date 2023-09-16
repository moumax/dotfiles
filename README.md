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
<br /><br /><br />
