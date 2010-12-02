#!/bin/bash

# Copy(replace) vim files.

echo "Files are being copied!"
cp -rf $UTILS_PROJECT_PATH/HOME/.vim ~/
cp -rf $UTILS_PROJECT_PATH/HOME/.vimrc ~/.vimrc
mkdir ~/.vim/backups ~/.vim/tmp
echo "done!"
