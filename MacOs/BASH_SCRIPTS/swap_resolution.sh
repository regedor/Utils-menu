#!/bin/bash
if [ "$1" = "" ] ; then
  if [ "$(xrandr | grep 'current 1280 x 800')" = "" ] ; then
    xrandr -s 1280x800
  else
    xrandr -s 640x480
  fi
else
  xrandr -s $1
fi
