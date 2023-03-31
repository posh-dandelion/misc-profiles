!#/bin/bash

touch ~/.hushlogin
sudo apt update && sudo apt install tmux lolcat fortune-mod kali-win-kex zsh zsh-autosuggestions vim kali-linux-large -y
wget https://raw.githubusercontent.com/posh-dandelion/misc-profiles/main/.zshrc -O ~/.zshrc
sudo sed -i "s-/bin/bash-/bin/zsh-g" /etc/passwd
sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo mount -o remount,rw /tmp/.X11-unix # https://github.com/microsoft/WSL/issues/9303
kex start

# If kex fails to start: https://unix.stackexchange.com/questions/727668/windows-11-win-kex-keymap-failed-to-compile
# 
# I had this only on W10. kex worked for ages and then started failing with exactly that error.
# You can install WSL from the MS Store in addition to the version baked into the OS. This seemingly breaks kex.
# Uninstalling the MS Store version of Windows Subsystem for Linux from the Programs menu (not Windows Features) fixed it for me. No further uninstalling / reinstalling of anything was necessary.
#

