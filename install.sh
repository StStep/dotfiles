#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir="$(pwd)"                               # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)" # old dotfiles backup directory
files="vimrc gitconfig"                    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating '$backupDir' for backup of any existing dotfiles in ~/"
mkdir -p "$backupDir"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
cd "$dir"
for file in $files; do
    mv "$HOME/.$file" "$backupDir/$file" 2>/dev/null
    if [ -e "$HOME/.$file" ]
    then
        rm "$HOME/.$file"
    fi
    ln -s "$dir/$file" "$HOME/.$file"
	echo
done
echo done

