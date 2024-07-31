{ pkgs, config, osConfig, ... }:

{
  imports = [
    ../../common/home/home.nix
    ./bash.nix
    ./zsh.nix
  ];

  home = {
    sessionVariables = rec {
      CMAKE_BUILD_PARALLEL_LEVEL = 4;
      PROJECTS_DIR = "${osConfig.services.syncthing.dataDir}/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };
  };
}
