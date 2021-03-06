{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This isn't needed (or allowed) if home-manager.useGlobalPkgs is true.
  #nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
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

    # Display managers source .xprofile instead of .profile, which is where
    # parts of home-manager's configuration ends up. To fix this I source
    # .profile from .xprofile.
    file.".xprofile".text = ''
      #!/bin/sh
      . /home/johan/.profile
      '';

    sessionVariables = {
      LESSHISTFILE = "-";
      EDITOR = "kak";
      CMAKE_BUILD_PARALLEL_LEVEL = 12;
      CMAKE_EXPORT_COMPILE_COMMANDS = 1;
    };

    packages = with pkgs; [
      # Other
      discord
      ffmpeg
      keepassxc
      youtube-dl

      # Development
      qtcreator
      universal-ctags

      #Document
      libreoffice
      pandoc
    ];
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    }
    '';

  programs.git = {
    enable = true;
    userName = "Johan Sandred";
    userEmail = "johan.sandred@protonmail.com";
    lfs.enable = true;
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "kak";
      };
    };
  };

  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      gpu-api = "vulkan";
      cscale = "ewa_lanczos";
      scale = "ewa_lanczossharp";
      tscale = "oversample";
      interpolation = true;
      video-sync = "display-resample";
    };
  };

  programs.kakoune = import ./kak/kakrc.nix pkgs;
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak/kak-lsp.toml;

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
    ];
  };

  programs.firefox = import ./firefoxrc.nix pkgs.nur.repos.rycee.firefox-addons;

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      rmdir = "rmdir -pv";
      rm = "rm -Iv";

      make = "make -j12";
      cmake = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";

      ls = "ls --color=auto -h --group-directories-first";
      ll = "ls -l";
      la = "ls -A";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      diff = "diff --color=auto";

      cxx17 = "c++ -std=c++17";
      cxx20 = "c++ -std=c++20";
    };
  };
}
