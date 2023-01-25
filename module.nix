{ config
, modprobe
, asus-fan-control
, ... }:

{

  config = {

    boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    services.systemd."asus-fan-control" = {
      enable = true;
      path = [ modprobe asus-fan-control ];

      description = "Executes asus-fan-control whenever necessary.";
      before = "multi-user.target";
      after = "hibernate.target" "suspend-then-hibernate.target";

      type = "oneshot";
      preStart = "modprobe acpi_call";
      script = "asus-fan-control";

      wantedBy = [ "multi-user.target" "hibernate.target" "suspend-then-hibernate.target" ];
    };
  }:
}
