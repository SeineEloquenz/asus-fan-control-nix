{
  description = "Nix packaged asus fan control";

  outputs = { self, nixpkgs }:
  {

    nixosModules = {
      asus-fan-control = import ./module.nix;
      default = self.nixosModules.asus-fan-control;
    };
  };
}
