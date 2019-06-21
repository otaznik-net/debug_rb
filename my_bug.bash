#!/bin/bash
file=${1%:*}
break_point=$1

echo "break ${break_point}" > .byebugrc

byebug --no-stop ${file}

if [ -f .byebugrc ]; then
  rm .byebugrc
fi
