{ ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "erasedups" "ignorespace" ];
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      rmdir = "rmdir -pv";
      rm = "rm -Iv";

      cmake = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";

      grep = "rg";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      diff = "diff --color=auto";

      cxx17 = "c++ -std=c++17";
      cxx20 = "c++ -std=c++20";

      cat = "bat";

      wrap = "fmt";
    };
  };
}
