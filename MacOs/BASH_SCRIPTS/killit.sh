#!/bin/bash
echo "Processes marked for death:"
ps -A | grep $1
echo "Ready to kill them?(y/n)"
read -n1 KEY
echo ""

if [[ "$KEY" = "y" || "$KEY" = "Y" ]] ; then
  kill $(ps -A | grep $1 | egrep "^\s*[0-9]+" -o)
  echo You are the killer man!
else
  echo "You don't have the guts to kill them all!"
  echo "Or maybe you just pressed the wrong key."
fi
