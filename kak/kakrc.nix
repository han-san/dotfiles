pkgs:
{
  enable = true;
  config = {
    indentWidth = 2;
    ui.assistant = "none";
    showMatching = true;
    numberLines = {
      enable = true;
      relative = true;
    };
    keyMappings = import ./kakkeymappings.nix;
    hooks = [
      {
        name = "WinSetOption";
        option = "filetype=(haskell|c|cpp|rust|python|javascript|typescript|latex)";
        commands = "lsp-enable-window";
      }
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
    ];
  };
  extraConfig =
    ''
    eval %sh{kak-lsp --kakoune -s $kak_session}
    lsp-auto-hover-enable
    set global lsp_hover_anchor true
    '';

  plugins = with pkgs.kakounePlugins; [
    kak-lsp
  ];
}
