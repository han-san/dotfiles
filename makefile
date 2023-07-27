default:
	@echo "You must specify a target to make"
laptop:
	cp -b configuration-laptop.nix /etc/nixos/configuration.nix
	cp -br * /etc/nixos/
server:
	cp -b configuration-server.nix /etc/nixos/configuration.nix
	cp -br * /etc/nixos/

.PHONY: default laptop server
