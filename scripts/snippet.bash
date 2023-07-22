#! /usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [[ ! -v SNIPPETS_DIR || -z "$SNIPPETS_DIR" ]]; then
  printf "The SNIPPETS_DIR environment variable must be set to a non-empty string."
  exit 1
fi

if [[ ! -d "$SNIPPETS_DIR" ]]; then
  printf "The SNIPPETS_DIR environment variable does not point to a directory."
  exit 1
fi

if [[ "$#" -gt 1 ]]; then
  printf "Usage: snippet [filename]"
  exit 1
fi

OUT_FILE_PATH=${1:-./}
CHOSENFILE=$(fd . "$SNIPPETS_DIR" | sk --header="Which snippet do you want to copy?")
RETVAL=$?

if [[ $RETVAL != 0 ]]; then
  exit 1
fi

cp -i "$CHOSENFILE" "$OUT_FILE_PATH"
