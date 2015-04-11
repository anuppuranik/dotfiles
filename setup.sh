#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

function symlnk {
    # Dont care for existing files or links. Just delete them.
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

