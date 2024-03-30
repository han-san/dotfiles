{ stdenv
, fetchFromGitHub
, lib
}:
stdenv.mkDerivation {
  pname = "cppfront";
  version = "unstable-2023-11-25";

  src = fetchFromGitHub {
    repo = "cppfront";
    owner = "hsutter";
    rev = "bc828333e0556cbcc59faae9ad7f30cb3d3fb58b";
    sha256 = "0780gjmd72hmz7k1yadshg2k8pwgjz1wgm9jwa49dbjlgq9wrzqf";
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
