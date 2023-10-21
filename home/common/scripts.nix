{ config, pkgs, ... }:
{
  home.packages = let
    SCRIPTS_DIR = config.home.sessionVariables.SCRIPTS_DIR;
  in with pkgs; [
    # Custom
    (writeShellApplication {
      name = "snippet";
      runtimeInputs = [ fd fzf ];
      text = (builtins.readFile "${SCRIPTS_DIR}/snippet.bash");
    })
    (writeShellApplication {
      name = "todo-add";
      text = (builtins.readFile "${SCRIPTS_DIR}/todo-add.sh");
    })
    (writeShellApplication {
      name = "todo-complete";
      runtimeInputs = [ fzf ];
      text = (builtins.readFile "${SCRIPTS_DIR}/todo-complete.sh");
    })
    (writeShellApplication {
      name = "todo-edit";
      runtimeInputs = [ emacs ];
      text = (builtins.readFile "${SCRIPTS_DIR}/todo-edit.sh");
    })
    (writeShellApplication {
      name = "todo-show";
      runtimeInputs = [ bat ];
      text = (builtins.readFile "${SCRIPTS_DIR}/todo-show.sh");
    })
    (writeShellApplication {
      name = "cleanbootgenerations";
      text = (builtins.readFile "${SCRIPTS_DIR}/cleanbootgenerations.sh");
    })
  ];
}
