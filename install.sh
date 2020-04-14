#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir="$(pwd)"                    # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)"            # old dotfiles backup directory
files="vimrc gitconfig"    # list of files/folders to symlink in homedir

##########

# Show working directory
echo "Using working current: $dir"
echo

# init and update Git submodules
echo "Init and update Git Submodules"
git submodule update --init --recursive
echo

# vim-pathogen install: http://stackoverflow.com/a/14545852

# create dotfiles_old in homedir
echo "Creating '$backupDir' for backup of any existing dotfiles in ~/"
mkdir -p "$backupDir"
echo "Done."
echo

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd "$dir"
echo "Done."
echo 

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from $HOME/.$file to $backupDir/.$file"
    mv "$HOME/.$file" "$backupDir/$file"
    if [ -e "$HOME/.$file" ]
    then
        echo "Removing existing dotfile"
        rm "$HOME/.$file"
    fi
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/.$file"
	echo
done
echo 

echo
echo "For further information or to post an issue please go to the GitHub repository page:"
echo "  https://github.com/Glavin001/dotfiles"
echo "Thank you and enjoy!"
echo
