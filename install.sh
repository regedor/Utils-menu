#!/bin/bash
if [ "$UTILS_PROJECT_PATH" = "" ] ; then
  echo "## Regedor Utils Scripts."                                                                           >> ~/.bashrc
  echo "export UTILS_PROJECT_PATH=\"$(dirname $0)\""                                                    >> ~/.bashrc
  echo "source `dirname $0`/BASHRC/bashrc"                                                              >> ~/.bashrc
  echo  export PS1="'"'\[\033[0;35m\]\h \[\033[0;33m\]\w\[\033[0;32m\] $(parse_git_branch)\[\033[00m\]: '"'" >> ~/.bashrc
  echo "Restart your bash and run utils-menu."
else
  echo "It seems you have already installed Utils Project by Regedor."
  echo "Try utils-menu command for more information."
fi
