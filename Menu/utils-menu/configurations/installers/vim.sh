#!/bin/bash
echo "Choose what to do."
echo "1 - Copy(replace) vim files."
echo "2 - Copy(replace) all HOME files."
echo "0 - Leave"
echo "Enter option number:"
read -n1 KEY
echo ""
case "$KEY" in
  "1" ) echo "Files are being copied!"
        cp -rf $UTILS_PROJECT_PATH/HOME/.vim ~/
        cp -rf $UTILS_PROJECT_PATH/HOME/.vimrc ~/.vimrc
        mkdir ~/.vim/backups ~/.vim/tmp
	echo "done!"
        ;;
  "2" ) echo "Files are being copied!"
        cp -rf $UTILS_PROJECT_PATH/HOME/* ~/ 
	echo "done!"
	;;
  "0" ) echo "This is end of the Script!"
        return 0
        ;;
  *   ) echo "Wrong option!"
        return 1
        ;;
esac
