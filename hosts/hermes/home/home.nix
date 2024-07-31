{ pkgs, config, osConfig, ... }:

{
  imports = [
    ../../common/home/home.nix
    ../../common/home/home-non-server.nix
    ./bash.nix
    ./zsh.nix
  ];

  home = {
    sessionVariables = rec {
      CMAKE_BUILD_PARALLEL_LEVEL = 16;
      MOZ_USE_XINPUT2 = 1;
      PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      SNIPPETS_DIR = "${PROJECTS_DIR}/snippets";
      SCRIPTS_DIR = "${PROJECTS_DIR}/scripts";
      TODO_FILE = "${osConfig.services.syncthing.dataDir}/Todos/TODO.org";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
