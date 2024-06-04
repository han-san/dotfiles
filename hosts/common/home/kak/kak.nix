{ pkgs, config, ... }:

{
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  xdg.configFile."kak-tree-sitter/config.toml".source = ./kak-tree-sitter.toml;
  xdg.configFile."kak/colors/catppuccin_mocha.kak".source = pkgs.fetchurl {
    url = "https://git.sr.ht/~hadronized/kakoune-tree-sitter-themes/blob/ab2de9bd73595be71a02c6a24dd2c1e6ae00a65f/colors/catppuccin/catppuccin_mocha.kak";
    hash = "sha256-fAcOfZdkGP1dNvr9SLaM6X/xK0+cAyGWgak7+euxjUU=";
  };
  xdg.configFile."kak/colors/night-owl.kak".source = pkgs.fetchurl {
    url = "https://git.sr.ht/~hadronized/kakoune-tree-sitter-themes/blob/ab2de9bd73595be71a02c6a24dd2c1e6ae00a65f/colors/nightowl/night-owl.kak";
    hash = "sha256-2GNRrw9EnLxyxu9ilvsu65MYzbBU9nFdbuIhCTUiT80=";
  };
  xdg.configFile."kak/colors/catppuccin_macchiato.kak".source = pkgs.fetchurl {
    url = "https://git.sr.ht/~hadronized/kakoune-tree-sitter-themes/blob/ab2de9bd73595be71a02c6a24dd2c1e6ae00a65f/colors/catppuccin/catppuccin_macchiato.kak";
    hash = "sha256-h4W3bWHdxmoN36zzIyQACaYA2PfoXSjf/hq5mAs8BBE=";
  };

  home.packages = with pkgs; [
    # Required for kakoune-gdb.
    gdb
    perl
    socat
    rr # Optional

    # Required for kak-fzf
    fzf
  ];

  programs.kakoune = {
    enable = true;
    config = {
      indentWidth = 2;
      ui.assistant = "none";
      ui.enableMouse = true;
      showMatching = true;
      scrollOff = {
        columns = 2;
        lines = 3;
      };
      colorScheme = null; # The colorscheme should be set AFTER kak-tree-sitter has been started.
      numberLines = {
        enable = true;
        relative = true;
      };
      keyMappings = import ./kakkeymappings.nix;
      hooks = [
        {
          name = "BufCreate";
          option = ".*\.typ";
          commands = "set-option buffer filetype typst";
        }
        {
          name = "WinSetOption";
          option = "filetype=typst";
          commands = ''
            hook buffer BufWritePost .* %{
              nop %sh{ ${pkgs.typst}/bin/typst compile "$kak_buffile" }
            }
          '';
        }
        {
          name = "WinSetOption";
          option = "filetype=(haskell|c|cpp|csharp|rust|python|javascript|typescript|latex|typst|dart|nix|go|cmake)";
          commands = ''
            lsp-enable-window
            lsp-inlay-diagnostics-enable window
            lsp-inlay-hints-enable window
            lsp-inlay-code-lenses-enable window
          '';
        }
        # {
        #   name = "WinSetOption";
        #   option = "filetype=(typescript|javascript)";
        #   commands = ''
        #     hook window BufWritePre .* %{ nop sh{ echo "from $kak_buffile" >out.log; prettier -w $kak_buffile >>out.log 2>err.log} }
        #   '';
        # }
        {
          name = "WinSetOption";
          option = "filetype=rust";
          commands =
            ''
              hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
              hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
              hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
              hook -once -always window WinSetOption filetype=.* %{
                remove-hooks window rust-inlay-hints
              }
            '';
        }
        {
          name = "BufCreate";
          option = "\\*harpoon\\*";
          commands = "set-face buffer function blue";
        }
        {
          name = "ModuleLoaded";
          option = "fzf";
          commands = "set-option global fzf_highlight_command 'bat'";
        }
        {
          name = "ModuleLoaded";
          option = "fzf-file";
          commands = "set-option global fzf_file_command 'fd'";
        }
        {
          name = "ModuleLoaded";
          option = "fzf-grep";
          commands =
            ''
              set-option global fzf_grep_command 'rg'
              set-option global fzf_grep_preview_command 'bat'
            '';
        }
      ];
    };
    extraConfig =
      ''
        eval %sh{ kak-tree-sitter -dks --with-highlighting --with-text-objects -vvvvv --init $kak_session }
        colorscheme catppuccin_mocha
        eval %sh{kak-lsp --kakoune -s $kak_session}
        set global lsp_hover_anchor true
        lsp-auto-signature-help-enable
        set-option global lsp_hover_anchor true
        set-option global lsp_auto_show_code_actions true

        source ${config.home.sessionVariables.PROJECTS_DIR}/impurekaktestrc.kak
      '';


    plugins =
      with pkgs.kakounePlugins;
      let
        csharp-kak =
          pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
            pname = "csharp.kak";
            version = "2020-08-08";
            src = pkgs.fetchFromGitHub {
              owner = "mspielberg";
              repo = "csharp.kak";
              rev = "0cec0cea23b4f77a6dbcada4edaa4f6517228fcd";
              sha256 = "1yryjwwhm0rfrj24ph5rjsljapma346g7m7gjgqjdd28iwv94flf";
            };
            meta.homepage = "https://github.com/mspielberg/csharp.kak";
          };
        kakoune-mirror =
          pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
            pname = "kakoune-mirror";
            version = "2020-09-07";
            src = pkgs.fetchFromGitHub {
              owner = "Delapouite";
              repo = "kakoune-mirror";
              rev = "5710635f440bcca914d55ff2ec1bfcba9efe0f15";
              sha256 = "0fd65clx9p6sslrl3l25m8l9ihl2mqrvvmmkjqr3bgk16vip3jds";
            };
            meta.homepage = "https://github.com/Delapouite/kakoune-mirror/";
          };
        kak-harpoon =
          pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
            pname = "kak-harpoon";
            version = "2023-09-08";
            src = pkgs.fetchFromGitHub {
              owner = "raiguard";
              repo = "kak-harpoon";
              rev = "15e0a01d2c5720c576375e7e6b271a5f84dcad2";
              sha256 = "0w3rvhq1y64512g9vpbprmm85v7zyw6nblcbpgfg7cs0vkpizv35";
            };
            meta.homepage = "https://github.com/raiguard/kak-harpoon/";
          };
        kakoune-gdb =
          pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
            pname = "kakoune-gdb";
            version = "2024-01-08";
            src = pkgs.fetchFromGitHub {
              owner = "occivink";
              repo = "kakoune-gdb";
              rev = "e4264aa1ba133f6e7188a6e55c2b47ffb40180b6";
              sha256 = "0w4wgi0bn72f8gq5pyjnsc4mi8pix8yid7pd3mx4lr3fz57mcv1h";
            };
            meta.homepage = "https://github.com/occivink/kakoune-gdb/";
          };
        kak-tree-sitter =
          pkgs.rustPlatform.buildRustPackage {
            pname = "kak-tree-sitter";
            version = "2024-05-30";

            src = pkgs.fetchFromSourcehut {
              owner = "~hadronized";
              repo = "kak-tree-sitter";
              rev = "295ff83f7606822201f1559434828ab680b271f2";
              hash = "sha256-XV5eNqlvFmQga1H6DzIqGfoMdWCo4eVstwI/KxGZQbI=";
            };

            cargoHash = "sha256-VHu11R0/y5sQ45io8M9HlKTv7lAUXUT/XcK/4eC/l6U=";

            nativeBuildInputs = [ pkgs.git ];

            meta = with pkgs.lib; {
              description = "Server between Kakoune and tree-sitter";
              homepage = "https://git.sr.ht/~hadronized/kak-tree-sitter";
              license = with licenses; [ bsd3 ];
              maintainers = [ "han-san" ];
              mainProgram = "kak-tree-sitter";
            };
          };
      in
      [
        kak-tree-sitter
        kakoune-lsp
        kak-fzf
        kakoune-mirror
        kak-harpoon
        auto-pairs-kak
        kakoune-gdb
        csharp-kak
      ];
  };
}
