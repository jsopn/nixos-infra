{ lib, pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  powerManagement = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    powertop
  ];

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
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave";

        INTEL_GPU_MAX_FREQ_ON_BAT = "950";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 30;

        USB_AUTOSUSPEND = 0;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging
      };
    };
  };
}
