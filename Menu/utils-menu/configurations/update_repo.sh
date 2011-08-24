#!/bin/bash

GITREPO="$1"
if [ -z "$GITREPO" ]; then
	GITREPO="."
fi

cd "$GITREPO"
git fetch > /tmp/$$.updaterepo 2>/dev/null
git submodule foreach git fetch | grep -v -P "^Entering" >> /tmp/$$.updaterepo 2>/dev/null
GITCHANGES=$(cat /tmp/$$.updaterepo)
if [ -n "$GITCHANGES" ]; then
	EXIT="NO"
	while [ "$EXIT"=="NO" ]; do
		echo "Looks like there are updates available for "$1"."
		echo "What do you want do do? [Ignore]"
		echo -e " [S]#See git-fetch output\n [U]#Update" | column -s'#' -t
		read -p "Option: "

		case $REPLY in
		S|s)
			echo
			echo "git-fetch output:"
			echo
			cat /tmp/$$.updaterepo
			echo
			EXIT="NO"
			;;
		U|u)
			git pull
			git submodule foreach git pull
			EXIT="YES"
			;;
		*)
			echo "Ignoring updates."
			rm -f /tmp/$$.updaterepo
			exit 0;
			;;
		esac
	done
fi

rm -f /tmp/$$.updaterepo
exit 0
