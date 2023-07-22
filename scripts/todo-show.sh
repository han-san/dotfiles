#! /bin/sh

set -eu
IFS=$(printf "\n\t")

if [ -z "$TODO_FILE" ]; then
  echo "The TODO_FILE variable must be set"
  exit 1
fi

bat "$TODO_FILE"
