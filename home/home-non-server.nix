{ pkgs, config, osConfig, ... }:

{
  imports = [
    ./common/firefox.nix
    ./common/mpv.nix
  ];

  home = {

    # Display managers source .xprofile instead of .profile, which is where
    # parts of home-manager's configuration ends up. To fix this I source
    # .profile from .xprofile.
    file.".xprofile".text = ''
      #!/bin/sh
      . ${config.home.homeDirectory}/.profile
      '';

    sessionVariables =
      with config.xdg;
    {
      CMAKE_EXPORT_COMPILE_COMMANDS = 1;
      EDITOR = "kak";
      CONAN_USER_HOME = configHome;
      CARGO_HOME = "${dataHome}/cargo";
      GRADLE_USER_HOME = "${dataHome}/gradle";
      GTK2_RC_FILES = "${configHome}/gtk-2.0/gtkrc";
      XCOMPOSECACHE = "${cacheHome}/X11/xcompose";
      NODE_REPL_HISTORY = "${dataHome}/node_repl_history";
      NUGET_PACKAGES = "${dataHome}/NuGetPackages";
      OMNISHARPHOME = "${configHome}/omnisharp";
    };

    packages = with pkgs; [
      anki-bin
      discord
      jellyfin-mpv-shim
      keepassxc
      qbittorrent
      teams
      zoom-us
      gnomeExtensions.caffeine

      jetbrains.rider
      jetbrains.clion
      qtcreator

      libreoffice
      # Other
      hyperfine

      # Development
      flutter
      tokei
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
      pandoc
      texlab #lsp
    ];
  };

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

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
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

  services.dunst = {
    enable = true;
  };

  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit (tpkgs) scheme-basic;
    };
  };

  programs.yt-dlp = {
    enable = true;
  };

}
