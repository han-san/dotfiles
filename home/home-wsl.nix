{ pkgs, config, osConfig, ... }:

{
  imports = [
    ./home-common.nix
    ./desktop/bash.nix
  ];

  home = {
    sessionVariables = rec {
      CMAKE_BUILD_PARALLEL_LEVEL = 12;
      PROJECTS_DIR = "/mnt/c/Users/johan/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };

    packages = with pkgs; [
      (pkgs.callPackage ./cppfront.nix { })
      cmake-language-server
      typst
      typst-lsp
    ];
  };
}
