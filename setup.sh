#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

function symlnk {
    # Dont care for existing files or links. Just delete them.
    echo "Symlinking $DOTFILES_DIR/$1"
    rm -f $HOME/$1
    ln -s $DOTFILES_DIR/$1 $HOME/$1
}

symlnk .bashrc
symlnk .bash_profile
symlnk .vimrc
symlnk .functions
symlnk .aliases
symlnk .exports
symlnk .bash_prompt
symlnk .path
symlnk .gitconfig


# Create symlinks to Sublime Text settings
# Check if sublime text is running.
if [[ $(ps -aef  | grep 'Sublime Text'| wc -l) -gt 1 ]]; then
    echo “You are running Sublime Text. Please close and re-run. Bye.”
    exit 1
fi

if [[ $(uname -s) == "Darwin" ]]; then
    # I am on mac
    SUBLIME_USER_DIR=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
fi

for file in $DOTFILES_DIR/sublime/* ; do
    filename=$(basename "$file")
    cmp -s "$file" "$SUBLIME_USER_DIR/$filename" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo "Symlinking $file"
        ln -sf "$file" "$SUBLIME_USER_DIR/$filename"
    else
        printf "\t$file\n"
        echo "is different from"
        printf "\t$SUBLIME_USER_DIR/$filename\n"
        echo "----------"
        diff "$file" "$SUBLIME_USER_DIR/$filename"
        echo "----------"
        read -p "What do you want to do? (N)othing/(D)eleteAndSymlink/(S)topThisScript " yesno
        case $yesno in
            [Nn] ) echo "skipped" ;;
            [Dd] ) echo "Symlinking $SUBLIME_USER_DIR/$filename" && ln -sf "$file" "$SUBLIME_USER_DIR/$filename" ;;
            [Ss] ) echo "As you wish. Bye" && exit 1 ;;
               * ) echo "Unknown option. Bye" && exit 1 ;;
        esac
    fi
done;
unset file;

