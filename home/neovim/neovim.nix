{ ... }:
let
  vimrc = builtins.readFile ./init.vim;
in {
  home.file.".ideavimrc".text = vimrc;

  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
    };
    extraConfig = vimrc;
  };
}
