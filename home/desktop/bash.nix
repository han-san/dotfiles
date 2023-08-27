{ ... }:
{
  programs.bash = {
    shellAliases = {
      make = "make -j12";
    };
  };
}
