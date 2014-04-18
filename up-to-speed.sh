#!/bin/bash
if (( EUID == 0 )); then
    echo "You must NOT be root to run this." 1>&2
    echo "Why? Preferences are changed for the current user." 1>&2
    echo "If ran as root, those changes will not take place for you, but for root instead." 1>&2
    echo "Also, many files will be owned by root rather than you, messing up permissions." 1>&2
    exit 1
fi

sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install -y nautilus-open-terminal chromium-browser light-themes dmz-cursor-theme openjdk-7-jdk nodejs sublime-text-installer git meld eclipse maven
sudo npm install -g n less jshint
wget https://sublime.wbond.net/Package%20Control.sublime-package -P ~/.config/sublime-text-3/Installed\ Packages
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt
echo "source ~/.bash-git-prompt/gitprompt.sh" >> .bashrc

gsettings set org.gnome.desktop.wm.preferences theme 'Ambiance'
gsettings set org.gnome.desktop.interface gtk-theme 'Ambiance'
gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'
gsettings set org.gnome.desktop.interface clock-format 12h
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.shell.calendar show-weekdate true
gsettings set org.gnome.shell.overrides button-layout ':minimize,maximize,close'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false
gsettings set org.gnome.shell favorite-apps "['nautilus.desktop', 'chromium-browser.desktop', 'firefox.desktop', 'sublime-text.desktop', 'gnome-terminal.desktop']"
gsettings set org.gnome.gedit.preferences.ui notebook-show-tabs-mode 'auto'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor create-backup-copy false

git config --global merge.tool meld
git config --global diff.tool meld
git config --global --add color.ui true
git config --global user.email "Jonathan.Gawrych@gmail.com"
git config --global user.name "Jonathan.Gawrych"
git config --global mergetool.keepBackup false
git config --global push.default simple

cp ~/.bash-git-prompt/git-prompt-colors.sh ~/.git-prompt-colors.sh
sed -i -e 's/\xe2\x97\x8f/\xe2\x80\xa2/' -e 's/\xe2\x9c\x96/\xe2\x98\xa2\x20/' -e 's/\xe2\x9c\x9a/\xc2\xb1/' -e 's/\xe2\x9a\x91/\xe2\xad\x91/' -e 's/\xe2\x9a\x91/\xe2\xad\x91/' -e 's/\xe2\x86\x91\xc2\xb7/\xe2\x86\x91/' -e 's/\xe2\x86\x93\xc2\xb7/\xe2\x86\x93/' .git-prompt-colors.sh
printf '\n  GIT_PROMPT_START="$BoldBlue\w$ResetColor"\n  GIT_PROMPT_END=" $ "' >> .git-prompt-colors.sh

sudo mv /usr/bin/subl /usr/bin/sublime