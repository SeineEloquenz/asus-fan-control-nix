# asus-fan-control-nix
This repository provides a nix packaged version of [asus-fan-control](https://github.com/dominiksalvet/asus-fan-control).

## Add to system configuration
Add the following input to your system configuration flake:
```
asus-fan-control = {
  url = "github:SeineEloquenz/asus-fan-control-nix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
Import the module `asus-fan-control.nixosModules.asus-fan-control` into your configuration and set the option `services.asus-fan-control.enable = true`.
