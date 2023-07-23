{ ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      rmdir = "rmdir -pv";
      rm = "rm -Iv";

      make = "make -j16";
      cmake = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";

      #ls = "ls --color=auto -h --group-directories-first";
      #ll = "ls -l";
      #la = "ls -A";

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
