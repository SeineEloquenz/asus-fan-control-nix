{ lib
, stdenvNoCC
, fetchFromGitHub
, bash
, makeWrapper
, ... }:

let

  version = "3.13.0";

  src = fetchFromGitHub {
    repo = "asus-fan-control";
    owner = "dominiksalvet";
    rev = version;
    sha256 = "1ppfqmr3k1p6jf1443c1wkzfds0375cin2dlfhvjnr9nw6qldw3i";
  };

in stdenvNoCC.mkDerivation {

  pname = "asus-fan-control";
  inherit version;
  inherit src;

  buildInputs = [
    bash
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/{bin,share/{bash-completion/completions,asus-fan-control}}
    install -m644 $src/src/bash/afc-completion $out/share/bash-completion/completions/asus-fan-control
    install -m644 $src/src/data/models $out/share/asus-fan-control
    install -m755 $src/src/asus-fan-control $out/bin/asus-fan-control
    sed -i 's/\/usr\/share\/asus-fan-control\/models/$out\/share\/asus-fan-control\/models/' $out/bin/asus-fan-control
    wrapProgram $out/bin/asus-fan-control --prefix PATH : ${lib.makeBinPath [ bash ]}
  '';

}
