{ pkgs, config, osConfig, ... }:

{
  imports = [
    ./home-common.nix
    ./home-non-server.nix
    ./desktop/bash.nix
  ];

  home = {
    sessionVariables = rec {
      CMAKE_BUILD_PARALLEL_LEVEL = 12;
      PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };
  };

}