{ config, ... }:
let
  vimrc = builtins.readFile ./init.vim;
in
{
  # Using config.xdg.configHome errors.
  home.file.".config/ideavim/ideavimrc".text = vimrc;

  imports = [
    ./colorscheme.nix
    ./telescope.nix
  ];

  programs.neovim = {
    enable = true;
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
