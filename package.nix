{ lib
, stdenvNoCC
, fetchFromGitHub
, bash
, makeWrapper
, ... }:

let

  version = "3.14.0";

  afc-source = fetchFromGitHub {
    repo = "asus-fan-control";
    owner = "dominiksalvet";
    rev = version;
    sha256 = "1s9kkz1m5r8zrj82g4y0xd2dvlx42c97vxzm1q4ifnq2075bgyi6";
  };

in stdenvNoCC.mkDerivation {

  pname = "asus-fan-control";
  inherit version;

  src = afc-source;

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
    sed -i 's,$DATA_DIR,${afc-source}/src/data,' $out/bin/asus-fan-control
    wrapProgram $out/bin/asus-fan-control --prefix PATH : ${lib.makeBinPath [ bash ]}
  '';

}
