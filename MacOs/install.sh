#!/bin/bash
if [ "$UTILS_PROJECT_PATH" = "" ] ; then
  echo "## Regedor Utils Scripts. (edited by Zamith)" >> ~/.bash_profile
  echo "export UTILS_PROJECT_PATH=\"$(dirname $PWD/$0)\"" >> ~/.bash_profile
  echo "source `dirname $PWD/$0`/MacOS/BASHRC/bashrc" >> ~/.bash_profile
  echo  export PS1="'"'${PS1}:$(parse_git_branch)\[\033[00m\]: '"'" >> ~/.bash_profile
  echo "Restart your bash and run utils-menu."
  echo $0
else
  echo "It seems you have already installed Utils Project by Regedor."
  echo "Try utils-menu command for more information."
fi
