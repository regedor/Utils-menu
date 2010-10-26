#!/bin/bash
if [ -z $1 ] ; then
  echo "noweb2pdf by Miguel Regedor <miguelregedor@gmail.com>"
  echo ""
  echo "  Usage: noweb2pdf <filename.nw> [-s] [-rm]"
  echo ""
else
  noweb $1
  name=$(basename $1 .nw)
  pdflatex "$name".tex
  pdflatex "$name".tex
  while [ "$2" != "" ]; do
    case $2 in
      -s  | --show )    evince "$name".pdf
                        ;;
      -rm | --remove )  rm "$name".aux "$name".log "$name".out "$name".tex "$name".toc .log texput.log
                        ;;
      * )               echo "NOWEB2PDF: You have entered a wrong parameter!"
                        exit 1
    esac
    shift
  done

fi
