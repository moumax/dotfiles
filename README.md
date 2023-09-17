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

## SOME KEYBINDINGS

win+f => thunar
ctrl + h/j => switch between tmux windows

## SOME TIPS

To modify startups programs => /i3/conf
To modify screen => /i3/conf

## USEFULL COMMANDS

xrandr => show all screens connected or not (usefull to give i3 apps on certain screens)
xprop => show the name of programs to put name on i3 file
<br /><br /><br />
