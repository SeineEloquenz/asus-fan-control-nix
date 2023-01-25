{
  description = "Nix packaged asus fan control";

  outputs = { self, nixpkgs }:
  let

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

  in {

    packages.${system} = {
      asus-fan-control = pkgs.callPackage ./package.nix {};
      default = self.packages.x86_64-linux.asus-fan-control;
    };

    nixosModules = {
      asus-fan-control = import ./module.nix;
      default = self.nixosModules.asus-fan-control;
    };
  };
}
