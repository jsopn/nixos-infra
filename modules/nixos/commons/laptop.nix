{ lib, ... }:
{
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    thermald.enable = true;

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        scrollMethod = "twofinger";
        accelProfile = "adaptive";

        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };

    tlp = {
      enable = lib.mkDefault true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging
      };
    };
  };
}
