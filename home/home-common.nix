{ pkgs, config, osConfig, ... }:

{
  imports = [
    ./common/kak/kak.nix
    ./common/bash.nix
    ./common/neovim/neovim.nix
    ./common/scripts.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.11";

    username = "johan";
    homeDirectory = "/home/johan";

    sessionVariables = rec {
      LESSHISTFILE = "-";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
      HISTFILE = "${config.xdg.stateHome}/bash/history";
    };

    packages = with pkgs; [
      choose
      fd
      ripgrep
      universal-ctags
      shellcheck
      shfmt
      rnix-lsp
    ];
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  programs.tealdeer = {
    enable = true;
    settings = {
      display.use_pager = true;
    };
  };

  programs.zoxide.enable = true;

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    shortcut = "q";
    baseIndex = 1;
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -sa terminal-features \",xterm-256color:RGB\"
      set -g mouse on
    '';
  };

  programs.git = {
    enable = true;
    userName = "Johan Sandred";
    userEmail = "johan.sandred@protonmail.com";
    lfs.enable = true;
    delta.enable = true;
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "kak";
      };
      commit.verbose = true;
      init.defaultBranch = "main";
    };
    aliases = {
      a = "commit --amend";
      ane = "commit --amend --no-edit";
      s = "status";
      c = "commit";
      cm = "commit -m";
      co = "checkout";
    };
  };

  programs.emacs = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview='bat {}'" ];
    # Skim has a script for tmux integration, but there doesn't seem to
    # be a way to specify that that's what I want to use.
  };
}
