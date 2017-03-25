#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# If symlinks already exists, they are skipped, otherwise destiny files are moved to dotfiles 
# folder and respective symlinks created.
# Note: A backup folder is created with all .dotfiles (not symlinks) desired
############################

########## Variables
TIME=$(date "+%Y-%m-%d_%H-%M-%S")
DIR=~/dotfiles # dotfiles directory
OLDDIR=~/dotfiles_old_"$TIME" # old dotfiles backup directory
FILES=(.bashrc .config/* .profile .vimrc) # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $OLDDIR for backup of any existing dotfiles in ~"
mkdir -p "$OLDDIR"
echo "...done"

# change to the dotfiles directory
echo "Changing to the $DIR directory"
cd $DIR
echo "...done"

# copy any existing dotfiles (follow symlinks) in homedir to dotfiles_old_$time directory
for FILE in "${FILES[@]}"; do
    echo "Backup dotfile $FILE from ~ to $OLDDIR"
    cp -L ~/$FILE "$OLDDIR"
done

# move any existing dotfiles (not symlinks) in homedir to dotfiles directory and create respective symlinks
for FILE in "${FILES[@]}"; do
    echo "Moving and creating symlink to $FILE from ~ to $DIR."
    ln -sfn $DIR/$FILE ~/$FILE
done

source ~/.bashrc
source ~/.vimrc

