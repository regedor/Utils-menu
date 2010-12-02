#!/bin/bash
if [ "$UTILS_PROJECT_PATH" = "" ] ; then
  mkdir $HOME/.utils-project
  cp -rf $PWD/* ~/.utils-project/
  echo "export UTILS_PROJECT_PATH=\"~/.utils-project/$0\"" >> ~/.bashrc
  echo "source ~/.utils-project/BASHRC/bashrc" >> ~/.bashrc
  source ~/.bashrc
  echo "Finished installing. You may now run utils-menu"
else
  echo "It seems you have already installed Utils Project by Regedor."
  echo "Try utils-menu command for more information."
fi

