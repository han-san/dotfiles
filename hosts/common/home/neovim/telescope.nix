{ config, pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];
    # FIXME: Don't work right
    extraLuaConfig = ''
      vim.keymap.set('n', '<Leader>pf', '<cmd>Telescope find_files<cr>')
    '';
  };
}
