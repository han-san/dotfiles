{ stdenv
, fetchFromGitHub
, lib
}:
stdenv.mkDerivation {
  pname = "cppfront";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "hsutter";
    repo = "cppfront";
    rev = "v0.7.2";
    hash = "sha256-vUhC8EFIhx1m+zT8n39c2fGjxqDbQ93rHfcu6Y7KN5M=";
  };

  buildPhase = ''
    runHook preBuild
    $CXX source/cppfront.cpp -std=c++20 -o cppfront
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 cppfront $out/bin/cppfront
    cp -r include $out/include
    runHook postInstall
  '';

  meta =
    let
      inherit (lib) platforms licenses maintainers;
    in
    {
      platforms = platforms.all;
      description = "An experimental compiler from a potential C++ 'syntax 2' (Cpp2) to today's 'syntax 1' (Cpp1)";
      homepage = "https://github.com/hsutter/cppfront";
      license = licenses.cc-by-nc-nd-40;
      maintainers = [
        maintainers.han-san
      ];
    };
}
