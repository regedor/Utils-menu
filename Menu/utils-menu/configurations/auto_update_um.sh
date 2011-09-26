#!/bin/bash

cd "$UTILS_PROJECT_PATH"
UMHASCHANGES=$(git status | grep "# Your branch is behind ")
cd - &>/dev/null

if [ -n "$UMHASCHANGES" ]; then
	EXIT="NO"
	while [ "$EXIT" = "NO" ]; do
		echo "Looks like there are updates available for utils-menu."
		echo "What would you like to do? [Ignore]"
		echo -e " [S]#See new commits\n [U]#Update sem medo!" | column -s'#' -t
		read -p "Option: "

		case $REPLY in
		S|s)
			echo
			cd "$UTILS_PROJECT_PATH"
			git log master..origin/master --pretty=format:"%an: %s"
			cd - &>/dev/null
			echo
			EXIT="NO"
			;;
		U|u)
			cd "$UTILS_PROJECT_PATH"
			git pull
			git submodule foreach git pull
			EXIT="YES"
			echo "utils-menu updated!"
			cd - &>/dev/null
			exit 0;
			;;
		*)
			echo "Ignoring updates."
			EXIT="YES"
			;;
		esac
	done
fi

(cd "$UTILS_PROJECT_PATH" && git fetch &>/dev/null &)
exit 0;



