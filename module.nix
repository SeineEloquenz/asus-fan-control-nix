{ config
, pkgs
, lib
, ... }:

let

  cfg = config.services.asus-fan-control;

  asus-fan-control = (pkgs.callPackage ./package.nix {});

in {

  options.services.asus-fan-control = with lib; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the asus fan control service";
    };
  };

  config = lib.mkIf cfg.enable {

    boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    systemd.services."asus-fan-control" = {
      enable = true;
      path = [ asus-fan-control ];

      description = "Executes asus-fan-control whenever necessary.";
      before = [ "multi-user.target" ];
      after = [ "hibernate.target" "suspend-then-hibernate.target" ];

      preStart = "modprobe acpi_call";
      script = "asus-fan-control";

      wantedBy = [ "multi-user.target" "hibernate.target" "suspend-then-hibernate.target" ];
    };
  };
}
