#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir="$(pwd)"                               # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)" # old dotfiles backup directory
ifiles="gitconfig gitignore"               # list of files/folders to symlink in homedir

if command -v vim > /dev/null 2>&1; then
  ifiles="${ifiles} vimrc"
  #ifiles="${ifiles} vim" Need to include vundle submodule and call submodule inti in this script
fi

##########

# Skip any that are already symlinks
files=""
for file in $ifiles; do
  if [[ ! -L "${HOME}/.${file}" ]]; then
    files="${files} ${file}"
    break
  fi
done

if [[ $files == "" ]]; then
    echo "Nothing to do"
    exit 0
fi

# create dotfiles_old in homedir
echo "Creating '$backupDir' for backup of any existing dotfiles in ~/ in list:"
echo "${files}"
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
done
echo done

# Post install setup
if command -v vim > /dev/null 2>&1; then
    #vim +PluginInstall +qall Need to have vundle setup
else
    git config --global core.editor vi
fi

