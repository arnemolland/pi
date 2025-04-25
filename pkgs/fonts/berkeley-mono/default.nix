{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "berkeley-mono-variable";
  version = "1.0.0";

  src = ./files;

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype *.ttf
  '';

  meta = with lib; {
    description = "Berkeley Mono Variable font";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
