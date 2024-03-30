{ pkgs, config, osConfig, ... }:

{
  imports = [
    ../../common/home/home.nix
    ../../gaia/home/bash.nix
  ];

  home = {
    sessionVariables = rec {
      CMAKE_BUILD_PARALLEL_LEVEL = 12;
      PROJECTS_DIR = "/mnt/c/Users/johan/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      DITHERCBZ_COLOR_MAP_LOCATION = "/mnt/d/Books/kindle_colors.gif";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };

    packages = with pkgs; [
      (pkgs.callPackage ../../common/cppfront.nix { })
      cmake-language-server
      typst
      typst-lsp
    ];
  };
}
