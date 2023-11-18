# Full windows and wsl installation on a new computer for developpers

## Install chocolatey

- Start powershell in admin mode

```powershell
Set-ExecutionPolicy AllSigned
```

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Install chocolatey packages

- Start powershell in admin mode

### Laptop

```powershell
choco install vlc runjs dbeaver adobereader ocenaudio powertoys vscode notion vivaldi windynamicdesktop
```

### Desktop

```powershell
choco install nvidia-display-driver vlc runjs adobereader ocenaudio dbeaver vscode msiafterburner steam notion vivaldi windynamicdesktop
```

### Update

```powershell
choco upgrade all --except="'skype,conemu'"
```

## Install WSL

- Run powershell in admin mode

```powershell
wsl --list --online
```

```powershell
wsl --install -d <Distribution Name>
```

## Install font

[Iosevka](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip)

- Change font on terminal preview
- Change transparency to 80% on terminal preview

## Speedup keyboard

HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response

```bash
AutoRepeatDelay = 200
AutoRepeatRate = 9
DelayBeforeAcceptance = 0
Flags = 59
```

## Install dynamic wallpapers

- Check wallpaper folder

## Msi after burner

- Underclock memory by -400 mhz
- Click windows icon
- Click disk icon
