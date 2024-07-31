{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    # Preserve the current directory of the shell across terminals using the VTE library.
    enableVteIntegration = true;
    autocd = true;
    autosuggestion.enable = true;
    # Since it's relative to the home directory,
    # using xdg.homeDir doesn't work.
    dotDir = ".config/zsh";
    defaultKeymap = "emacs";
    history = {
      # Adds a timestamp in the history file.
      extended = true;
      ignoreAllDups = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    oh-my-zsh = {
      enable = true;
      theme = "steeef";
      plugins = [
        "bgnotify"
        "colored-man-pages"
        "git-escape-magic"
        "gitfast"
        "safe-paste"
      ];
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "brackets"
        "pattern"
      ];
      patterns = {
        "rm -rf *" = "fg=white,bold,bg=red";
      };
    };
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      rmdir = "rmdir -v";
      rm = "rm -Iv";

      cmake = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";

      grep = "rg";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      diff = "diff --color=auto";

      cxx17 = "c++ -std=c++17";
      cxx20 = "c++ -std=c++20";

      cat = "bat";

      wrap = "fmt";
    };
  };
}
