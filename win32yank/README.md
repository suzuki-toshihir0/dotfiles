# Installation Guide for win32yank

Please locate `win32yank.exe` at your Windows filesystem, and make symbolic link to the exe file.
Proceed with the installation followingthe step below.

## Download .zip file

```cmd
powershell -command "Invoke-WebRequest -Uri 'https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip' -OutFile '%USERPROFILE%\Downloads\win32yank-x64.zip'"
powershell -command "Expand-Archive -Path '%USERPROFILE%\Downloads\win32yank-x64.zip' -DestinationPath '%USERPROFILE%\Downloads\win32yank'"
```

## Locate .exe file

```cmd
md "%LOCALAPPDATA%\win32yank" 2>nul
move "%USERPROFILE%\Downloads\win32yank\win32yank.exe" "%LOCALAPPDATA%\win32yank"
```

## Make symbolike link from your WSL2 environment

```sh
mkdir -p ~/bin
ln -s /mnt/c/Users/<YOUR-USER-NAME>/AppData/Local/win32yank/win32yank.exe ~/bin/win32yank.exe
```

