{ pkgs, lib, config, osConfig, ... }:

{
  imports = [
    ./firefox.nix
    ./mpv.nix
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
        NIXOS_OZONE_WL = 1;
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
      # logseq # organizing program kinda like obsidian
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
      (pkgs.callPackage ../cppfront.nix { })

      typst
      typst-lsp
      libreoffice
      # Other
      hyperfine
      tofi
      bluetuith
      obsidian
      gimp

      # Language servers
      nodePackages.bash-language-server
      nodePackages.vscode-css-languageserver-bin
      tailwindcss-language-server
      gopls
      nodePackages.vscode-html-languageserver-bin
      nodePackages.intelephense
      nodePackages.vscode-json-languageserver
      lua-language-server
      marksman
      yaml-language-server
      zls

      # Development
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
      nodePackages.typescript-language-server
      nodePackages.prettier
      ## Python
      (python3.withPackages (ps:
        with ps;
        [
          python-lsp-server
          pylsp-mypy
          pyls-isort
          python-lsp-black
          pyls-memestra
          pylsp-rope
          python-lsp-ruff
        ] ++ python-lsp-server.optional-dependencies.all))
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
      cmake-language-server
      cmake-format
      conan
      cppcheck
      gdb
      gnumake
      #lldb
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
      inherit (tpkgs) scheme-small;
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
        notify = "${pkgs.libnotify}/bin/notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";

        modules-left = [
          "sway/workspaces"
          "sway/scratchpad"
          "sway/mode"
          "privacy"
        ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "sway/language"
          "disk"
          "memory"
          "cpu"
          "temperature"
          "network"
          "bluetooth"
          "wireplumber"
          "power-profiles-daemon"
          "battery"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "sway/scratchpad" = {
          format = "🗒️ {count}";
        };

        "privacy" = {
          icon-size = 13;
          tooltip-icon-size = 13;
          icon-spacing = 0;
        };

        "sway/language" = {
          format = "⌨️ {}";
          tooltip-format = "{long}";
        };

        idle_inhibitor = {
          format = "{icon}";
          tooltip-format-activated = "Idle inhibit is {status}";
          tooltip-format-deactivated = "Idle inhibit is {status}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        disk = {
          format = "💾 {free}";
          states = {
            warning = 89;
            danger = 95;
          };
        };

        memory = {
          format = "🐏 {avail}GiB";
          tooltip-format = "Mem used: {used} / {total}GiB\nSwap used: {swapUsed} / {swapTotal}GiB";
          states = {
            warning = 85;
            danger = 90;
            critical = 95;
          };
        };

        cpu = {
          format = "🐹 {usage}% {load}";
          states = {
            warning = 70;
            danger = 95;
          };
        };

        temperature = {
          format = "🌡️{temperatureC}°C";
          tooltip = false;
          thermal-zone = 8;
          critical-threshold = 80;
        };

        network = {
          format-ethernet = "🌐";
          format-wifi = "🛜 {essid} {signalStrength}%";
          format-disconnected = "🛜 ⚠️";
          format-linked = "{ifname}: no IP";
          tooltip-format = "IP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
          on-click = "${pkgs.foot}/bin/foot nmtui";
        };

        bluetooth = {
          format-on = " {status}";
          format-connected = " {device_alias} {num_connections}";
          tooltip-format-connected = "Connected devices:\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          on-click = "${pkgs.foot}/bin/foot bluetuith";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "🔌 {capacity}%";
          format-icons = [ "🪫" "🔋" "🔋" ];
          states = {
            warning = 20;
            danger = 10;
            critical = 6;
          };
        };

        power-profiles-daemon = {
          format = "{icon}";
          format-icons = {
            default = "?";
            performance = "⚡";
            balanced = "⚖️";
            power-saver = "🌱";
          };
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "🔇 {volume}%";
          format-icons = [ "🔈" "🔉" "🔊" ];
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        tray = {
          spacing = 5;
        };

        clock = {
          format = "{:%a %F %H:%M}";
          tooltip-format = "<span size='9pt' font='Iosevka'>{calendar}</span>";
          calendar = {
            weeks-pos = "left";
            format = {
              today = "<span color='firebrick'>{}</span>";
              weeks = "<span color='yellow'>{} </span>";
            };
          };
        };
      };
    };
    style = ./waybarstyle.css;
  };

  programs.swaylock = {
    enable = true;
    settings = {
      image = "${config.xdg.userDirs.pictures}/wallpapers/hackerman.jpg";
      scaling = "fit";
    };
  };

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
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # Prevents the extraSessionCommands from causing the build to fail since the files and programs don't exist at that moment in the build process.
    checkConfig = false;
    # Makes sure profile files and environment are sourced properly.
    extraSessionCommands =
      let
        etcProfile = "/etc/profile";
        dotProfile = "${config.home.homeDirectory}/.profile";
      in
      ''
        test -f ${etcProfile} && source ${etcProfile}
        test -f ${dotProfile} && source ${dotProfile}
        systemctl --user import-environment
      '';
    config = {
      input = {
        "*" = {
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
      assigns = {
        "2" = [{ app_id = "^firefox$"; }];
      };
      modifier = "Mod4";
      menu = "${pkgs.tofi}/bin/tofi-drun --drun-launch=true";

      defaultWorkspace = "workspace number 1";

      # Inhibit swayidle (requires work, should be togglable in some way).
      # There is some other swaybar or something that allows for toggling it, I think.
      # window.commands = [
      #   {
      #     command = "inhibit_idle visible";
      #     criteria = {
      #       app_id = ".*";
      #     };
      #   }
      # ];

      # Switching windows to some workspaces doesn't work with glove80 (it probably interprets it as mod4+$ instead of mod4+shift+7
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          light = "${pkgs.light}/bin/light";
          pamixer = "${pkgs.pamixer}/bin/pamixer";
          notifier = "${pkgs.libnotify}/bin/notify-send";
          mpv = "${pkgs.mpv}/bin/mpv";
          python = "${pkgs.python3}/bin/python3";
        in
        lib.mkOptionDefault {
          "XF86MonBrightnessDown" = "exec ${light} -S $(${python} -c \"print(max(1, $(${light}) - 1))\") && ${notifier} --hint=string:x-dunst-stack-tag:light --urgency=low Brightness $(${light})";
          "XF86MonBrightnessUp" = "exec ${light} -A 1 && ${notifier} --hint=string:x-dunst-stack-tag:light --urgency=low Brightness $(${light})";

          "XF86AudioRaiseVolume" = "exec ${pamixer} -i 5; exec ${mpv} ${config.home.homeDirectory}/soundeffects/bloop.mp3";
          "XF86AudioLowerVolume" = "exec ${pamixer} -d 5; exec ${mpv} ${config.home.homeDirectory}/soundeffects/bloop.mp3";
          "XF86AudioMute" = "exec ${pamixer} -t";
        };
      fonts = {
        names = [ "Iosevka" ];
      };
      gaps.smartBorders = "on";
      workspaceAutoBackAndForth = true;
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
    };
  };
}
