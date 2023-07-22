#! /bin/sh

set -eu
IFS=$(printf "\n\t")

if [ "$(id -u)" -ne "0" ]; then
  echo "Error: Command must be run as root."
  exit 1
fi

nix-collect-garbage -d
nixos-rebuild boot
