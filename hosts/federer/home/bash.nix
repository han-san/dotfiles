{ ... }:
{
  programs.bash = {
    shellAliases = {
      make = "make -j4";
    };
  };
}
