{
  lib,
  stdenvNoCC,

  nushell,
}:

stdenvNoCC.mkDerivation {
  name    = "github2forgejo";
  version = "master";

  src = builtins.path {
    path = ./.;
    name = "source";
  };

  dontBuild     = true;
  dontConfigure = true;

  nativeBuildInputs = [ nushell ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp github2forgejo $out/bin

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    substituteInPlace $out/bin/github2forgejo \
      --replace '/usr/bin/env nu' '${lib.getExe nushell}'

    runHook postFixup
  '';

  meta = {
    description = "GitHub to Forgejo migration script";
    homepage    = "https://git.rgbcu.be/RGBCube/GitHub2Forgejo";
    license     = lib.licenses.gpl3Only;
    mainProgram = "github2forgejo";
  };
}
