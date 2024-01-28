{ pkgs, lib, config, osConfig, ... }:

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
      zoom-us
      gnomeExtensions.caffeine

      jetbrains.rider
      jetbrains.clion
      qtcreator
      (pkgs.callPackage ./cppfront.nix {})

      libreoffice
      # Other
      hyperfine
      tofi
      bluetuith

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

  xdg.configFile."tofi/config".text = ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 5
    font = monospace
    background-color = #000A
  '';

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
    keybindings =
      let
        makeKeyMap = k: c: w:
          {
            key = k;
            command = c;
            when = w;
          };
      in
      [
        (makeKeyMap "m" "dance.select.left.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "h" "-dance.select.left.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "h" "dance.seek.enclosing" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "m" "-dance.seek.enclosing" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "k" "dance.search.next" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "n" "-dance.search.next" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "e" "dance.select.up.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "k" "-dance.select.up.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "j" "dance.seek.wordEnd" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "e" "-dance.seek.wordEnd" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "n" "dance.select.down.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "j" "-dance.select.down.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "u" "dance.modes.insert.before" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "i" "-dance.modes.insert.before" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "l" "dance.history.undo" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "u" "-dance.history.undo" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "i" "dance.select.right.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "l" "-dance.select.right.jump" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+i" "dance.select.right.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+l" "-dance.select.right.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+i" "dance.select.lineEnd.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+l" "-dance.select.lineEnd.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+u" "dance.select.insert.lineStart" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+i" "-dance.select.insert.lineStart" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+u" "editor.action.insertCursorAtEndOfEachLineSelected" "editorTextFocus")
        (makeKeyMap "shift+alt+i" "-editor.action.insertCursorAtEndOfEachLineSelected" "editorTextFocus")
        (makeKeyMap "shift+h" "dance.seek.enclosing.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+m" "-dance.seek.enclosing.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+h" "dance.seek.enclosing.extend.backward" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+m" "-dance.seek.enclosing.extend.backward" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+m" "dance.select.left.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+h" "-dance.select.left.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+m" "dance.select.lineStart.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+h" "-dance.select.lineStart.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+k" "dance.search.next.add" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+n" "-dance.search.next.add" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+k" "dance.search.previous.add" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+n" "-dance.search.previous.add" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+e" "dance.select.up.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+k" "-dance.select.up.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+e" "dance.selections.filter.regexp.inverse" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+k" "-dance.selections.filter.regexp.inverse" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+j" "dance.seek.wordEnd.ws.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+e" "-dance.seek.wordEnd.ws.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+j" "dance.seek.wordEnd.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+e" "-dance.seek.wordEnd.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+l" "dance.history.redo" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+u" "-dance.history.redo" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+l" "dance.history.redo.selections" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+u" "-dance.history.redo.selections" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+n" "dance.select.down.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+j" "-dance.select.down.extend" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+n" "dance.edit.join.select" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "shift+alt+j" "-dance.edit.join.select" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+h" "dance.seek.enclosing.backward" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+m" "-dance.seek.enclosing.backward" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+e" "dance.selections.filter.regexp" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+k" "-dance.selections.filter.regexp" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+k" "dance.search.previous" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+n" "-dance.search.previous" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+j" "dance.seek.wordEnd.ws" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+e" "-dance.seek.wordEnd.ws" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+u" "dance.seek.askObject.inner" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+i" "-dance.seek.askObject.inner" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+u" "dance.seek.askObject.inner" "editorTextFocus && dance.mode == 'insert'")
        (makeKeyMap "alt+i" "-dance.seek.askObject.inner" "editorTextFocus && dance.mode == 'insert'")
        (makeKeyMap "alt+n" "dance.edit.join" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+j" "-dance.edit.join" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+i" "dance.select.lineEnd" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+l" "-dance.select.lineEnd" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+l" "dance.history.undo.selections" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+u" "-dance.history.undo.selections" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+m" "dance.select.lineStart" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "alt+h" "-dance.select.lineStart" "editorTextFocus && dance.mode == 'normal'")
        (makeKeyMap "ctrl+o" "workbench.action.navigateBack" "canNavigateBack")
        (makeKeyMap "ctrl+i" "workbench.action.navigateForward" "canNavigateForward")

        (makeKeyMap "ctrl+alt+n" "workbench.action.openEditorAtIndex1" null)
        (makeKeyMap "ctrl+alt+e" "workbench.action.openEditorAtIndex2" null)
        (makeKeyMap "ctrl+alt+i" "workbench.action.openEditorAtIndex3" null)
        (makeKeyMap "ctrl+alt+o" "workbench.action.openEditorAtIndex4" null)

      ];
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

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=9";
        notify = "${pkgs.dunst}/bin/dunstify -a \${app-id} -i \${app-id} \${title} \${body}";
      };
      csd = {
        color = "ff303030";
        button-color = "ffeeeeee";
        button-minimize-color = "ff3f3f3f";
        button-maximize-color = "ff3f3f3f";
        button-close-color = "ff3f3f3f";
      };
    };
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;
    modules = {
      "load" = {
        position = 1;
        settings = {
          format = "😴 %5min";
          format_above_threshold = "🤯 %1min %5min";
        };
      };
      "cpu_usage" = {
        position = 2;
        settings = {
          format = "🐹 %usage";
        };
      };
      "cpu_temperature 0" = {
        position = 3;
        settings = {
          format = "🌡️%degrees°C";
        };
      };
      "memory" = {
        position = 4;
        settings = {
          format = "🐏 %available";
        };
      };
      "disk /" = {
        position = 5;
        settings = {
          format = "💾 %avail";
        };
      };
      "battery 0" = {
        position = 6;
        settings = {
          last_full_capacity = true;
          format = "%status%percentage %remaining";
          status_chr = "🔌";
          status_bat = "🔋";
          status_unk = "🔋❓";
          status_full = "🔋👍";
        };
      };
      "wireless _first_" = {
        position = 7;
        settings = {
          format_up = "🛜 %essid%quality";
          format_down = "🛜 ⚠️";
        };
      };
      "volume master" = {
        position = 8;
        settings = {
          format = "🔊 %volume";
          format_muted = "🔇 %volume";
        };
      };
      "time" = {
        position = 9;
        settings = {
          format = "%A %Y-%m-%d %H:%M:%S";
        };
      };
    };
  };

  programs.swaylock.enable = true;

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      input = {
        "*" = {
          # FIXME: Is there a way to remove caps backspace? It screws up caps lock on glove80.
          xkb_variant = "colemak_dh_iso,";
          xkb_layout = "us,se";
          xkb_options = "grp:alt_caps_toggle,caps:capslock"; # caps:swapescape screws up glove80
          tap = "enabled";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
      };
      # FIXME: Things to do: get sway in display manager. Apparently the regular programs.sway = enable does it, but I don't know the status of home-manager's
      assigns = {
        "2" = [{ app_id = "^firefox$"; }];
      };
      modifier = "Mod4";
      menu = "${pkgs.tofi}/bin/tofi-drun --drun-launch=true";
      # Changing up, down, left, right means some keybinds are lost. They need to be added again.
      # Switching windows to some workspaces doesn't work with glove80 (it probably interprets it as mod4+$ instead of mod4+shift+7
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          light = "${pkgs.light}/bin/light";
          pamixer = "${pkgs.pamixer}/bin/pamixer";
          notifier = "${pkgs.dunst}/bin/dunstify";
        in
        lib.mkOptionDefault {
          # Doesn't work.
          "XF86MonBrightnessDown" = "exec ${notifier} brightdown"; #"exec ${light} -U 10"; # Notify or have in status bar
          "XF86MonBrightnessUp" = "exec ${notifier} brightup"; #"exec ${light} -A 10";

          "XF86AudioRaiseVolume" = "exec ${pamixer} -i 5 2>&1 >> /tmp/volume.log"; # Notify or have in status bar
          "XF86AudioLowerVolume" = "exec ${pamixer} -d 5 2>&1 >> /tmp/volume.log";
          "XF86AudioMute" = "exec ${pamixer} -t 2>&1 >> /tmp/volume.log";

          "${mod}+m" = "focus left";
          "${mod}+n" = "focus down";
          "${mod}+e" = "focus up";
          "${mod}+i" = "focus right";

          "${mod}+Shift+m" = "move left";
          "${mod}+Shift+n" = "move down";
          "${mod}+Shift+e" = "move up";
          "${mod}+Shift+i" = "move right";

          "${mod}+h" = "splith";

          "${mod}+t" = "layout toggle split";
          "${mod}+Shift+Control+Escape" = "exec swaymsg exit";
        };
      fonts = {
        names = [ "Iosevka" ];
      };
      gaps.smartBorders = "on";
      workspaceAutoBackAndForth = true;
      # FIXME: Is it possible to add the current keyboard layout? There's a program called xkblayout-state, but it segfaults. There's an issue on its github that might include a fix, so maybe compiling it from that repo makes it work?
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "bottom";
          workspaceButtons = true;
          workspaceNumbers = true;
          fonts = {
            names = [ "Iosevka" ];
          };
          statusCommand = "i3status"; # Create a script as mentioned in i3status' man page and call that to add current keyboard layout.
          trayOutput = "primary";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
    };
  };
}
