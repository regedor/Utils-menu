#!/bin/bash

GITREPO="$1"

cd "$1"
git fetch > /tmp/$$.updaterepo 2>/dev/null
GITCHANGES=$(cat /tmp/$$.updaterepo)
if [ -n "GITCHANGES" ]; then
	EXIT="NO"
	while [ "$EXIT"=="NO" ]; do
		echo "Looks like there are updates available for "$1"."
		echo "What do you want do do? [Ignore]"
		echo -e " [S]#See git-fetch output\n [U]#Update" | column -s'#' -t
		read

		case $REPLY in
		S|s)
			cat /tmp/$$.updaterepo
			EXIT="NO"
			;;
		U|u)
			git pull
			EXIT="YES"
			;;
		*)
			echo "Ignoring updates."
			exit 0;
			;;
		esac
	done
fi

exit 0
