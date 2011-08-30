#!/bin/bash

cd "$UTILS_PROJECT_PATH"
UMHASCHANGES=$(git status | grep "# Your branch is behind ")
cd -


if [ -n "$UMHASCHANGES" ]; then
	EXIT="NO"
	while [ "$EXIT"=="NO" ]; do
		echo "Looks like there are updates available for "$1"."
		echo "What would you like to do? [Ignore]"
		echo -e " [S]#See new commits\n [U]#Update sem medo!" | column -s'#' -t
		read -p "Option: "

		case $REPLY in
		S|s)
			echo
			cd "$UTILS_PROJECT_PATH"
			git log master..origin/master --pretty=format:"%an: %s"
			cd -
			echo
			EXIT="NO"
			;;
		U|u)
			cd "$UTILS_PROJECT_PATH"
			git pull
			git submodule foreach git pull
			EXIT="YES"
			echo "$0 updated"
			cd -
			;;
		*)
			echo "Ignoring updates."
			exit 0;
			;;
		esac
	done
fi

(cd "$UTILS_PROJECT_PATH" && git pull && cd - & &>/dev/null)



