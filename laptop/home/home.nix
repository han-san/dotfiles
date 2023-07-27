{ pkgs, config, osConfig, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./kak/kakrc.nix
    ./neovim/neovim.nix
    ./firefox.nix
    ./bash.nix
    ./mpv.nix
    ./scripts.nix
  ];

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
      . ${config.home.homeDirectory}/.profile
      '';

    sessionVariables = rec {
      LESSHISTFILE = "-";
      EDITOR = "kak";
      CMAKE_BUILD_PARALLEL_LEVEL = 16;
      CMAKE_EXPORT_COMPILE_COMMANDS = 1;
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
      MOZ_USE_XINPUT2 = 1;
      PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };

    packages = with pkgs; [
      # Other
      anki-bin
      choose
      discord
      fd
      jellyfin-mpv-shim
      hyperfine
      keepassxc
      qbittorrent
      youtube-dl
      teams
      zoom-us
      gnomeExtensions.caffeine

      # Development
      flutter
      jetbrains.rider
      jetbrains.clion
      qtcreator
      ripgrep
      tokei
      universal-ctags
      ## Haskell
      cabal-install
      ghc
      haskell-language-server #lsp
      stack
      ## JS
      nodejs
      nodePackages.typescript
      deno #lsp
      ## Python
      python3
      #python-lsp-server #lsp
      ## Shell
      shellcheck
      shfmt
      ## Rust
      cargo
      clippy
      rust-analyzer #lsp
      rustc
      rustfmt
      ## C++
      clang-analyzer
      clang-tools
      cmake
      cmake-format
      conan
      cppcheck
      gdb
      gnumake
      lldb
      ## Dotnet
      fsharp
      mono
      #msbuild
      dotnet-sdk

      #Document
      libreoffice
      pandoc
      texlab #lsp
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

      android_sdk.accept_license = true;
    }
    '';

  xdg.configFile."discord/settings.json".text = ''
    {
      "SKIP_HOST_UPDATE": true
    }
  '';

  programs.tealdeer = {
    enable = true;
    settings = {
      display.use_pager = true;
    };
  };

  programs.zoxide.enable = true;

  programs.bat.enable = true;

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    shortcut = "q";
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -sa terminal-features \",xterm-256color:RGB\"
      set -g mouse on
    '';
  };

  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit (tpkgs) scheme-basic;
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
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

  programs.chromium = {
    enable = true;
    #package = pkgs.ungoogled-chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.skim = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    # Skim has a script for tmux integration, but there doesn't seem to
    # be a way to specify that that's what I want to use.
  };

  #programs.fzf = {
    #enable = true;
    #changeDirWidgetCommand = "fd --type d";
    #defaultCommand = "fd --type f";
    #fileWidgetCommand = "fd --type f";
    #tmux.enableShellIntegration = true;
  #};

  services.dunst = {
    enable = true;
  };

}
