#! /bin/sh

set -eu
IFS=$(printf "\n\t")

if [ -z "$TODO_FILE" ]; then
  echo "The TODO_FILE variable must be set"
  exit 1
fi

INPUT_LINE=$(cat -n "$TODO_FILE" | grep '\* TODO ' | sk --tac --no-sort)

if [ -z "$INPUT_LINE" ]; then
  exit 1
fi

LINE_NUMBER=$(echo "$INPUT_LINE" | cut -f 1)

EDITED_FILE_CONTENT=$(awk -v LINE_NR="$LINE_NUMBER" 'NR == LINE_NR { sub("TODO", "DONE", $0); print $0 } NR != LINE_NR { print $0 }' "$TODO_FILE")

echo "$EDITED_FILE_CONTENT" | sort -k2 > "$TODO_FILE"

