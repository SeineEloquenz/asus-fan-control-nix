{
  description = "Nix packaged asus fan control";

  outputs = { self, nixpkgs }:
  let

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

  in {

    packages.${system}.default = pkgs.callPackage ./package.nix {};
    nixosModules.default = pkgs.callPackage ./module.nix {};

  };
}
