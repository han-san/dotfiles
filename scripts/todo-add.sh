#! /bin/sh

set -eu
IFS=$(printf "\n\t")

if [ -z "$TODO_FILE" ]; then
  echo "TODO_FILE variable is not set"
  exit 1
fi

cat "$TODO_FILE"
printf "Enter a new TODO: "
read -r TODO_INPUT

if [ -n "$TODO_INPUT" ]; then
  echo "* TODO $TODO_INPUT" >> "$TODO_FILE"
fi
