{ stdenv
, fetchFromGitHub
, bash
, makeWrapper
, makeBinPath
, ... }:

let

  version = "3.13.0";

in stdenv.mkDerivation {

  pname = "asus-fan-control";
  inherit version;

  src = fetchfromGitHub {
    repo = "asus-fan-control";
    owner = "dominiksalvet";
    rev = version;
    sha256 = "1ppfqmr3k1p6jf1443c1wkzfds0375cin2dlfhvjnr9nw6qldw3i";
  };

  buildInputs = [
    bash
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/{bin,lib,share/{bash-completion/completions,asus-fan-control}}
    install -m644 $src/bash/afc-completion $out/share/bash-completion/completions/asus-fan-control
    install -m644 $src/data/models $out/share/asus-fan-control
    install -m644 $src/.install/afc.service $out/lib/systemd/system/asus-fan-control.service
    install -m755 $src/asus-fan-control $out/bin/asus-fan-control
    wrapProgram $out/bin/asus-fan-control --prefix PATH : ${makeBinPath [ bash ]}
  '';

}
