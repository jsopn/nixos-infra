{ pkgs, ... }:
let
  notificationSound = builtins.path {
    path = ../../../lib/assets/sounds/notification-sound.wav;
    name = "notification-sound";
  };

  playSoundScript = pkgs.writeShellScriptBin "playNotificationSound" ''
    ${pkgs.alsa-utils}/bin/aplay "${notificationSound}"
  '';

in
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    qt5.qtwayland
  ];

  programs = {
    bemenu.enable = true;
    swaylock.enable = true;
    kitty.enable = true;
  };


  services = {
    dunst.enable = true;
    copyq.enable = true;

    swayidle = {
      enable = true;
      events = [
        { event = "lock"; command = "swaylock"; }
        { event = "before-sleep"; command = "swaylock"; }
        { event = "after-resume"; command = ''swaymsg "output * dpms on"''; }
      ];
      timeouts = [
        { timeout = 290; command = "${pkgs.libnotify}/bin/notify-send -t 10000 -u critical -- 'Screen Lock' 'Screen lock in 10 seconds'"; }
        { timeout = 300; command = "swaylock"; }
        { timeout = 360; command = ''swaymsg "output * dpms off"''; }
      ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      input "type:keyboard" {
        xkb_layout us,ru
        xkb_options grp:alt_shift_toggle
      }

      title_align center
    '';

    checkConfig = false;
    systemd.enable = true;
    wrapperFeatures.gtk = true;

    extraSessionCommands = ''
      export NIXOS_OZONE_WL=1
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1  
    '';

    config = rec {
      terminal = "kitty";
      menu = "bemenu-run -b";
      modifier = "Mod4";

      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";

        "${modifier}+w" = "kill";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+a" = "focus parent";
        "${modifier}+Shift+f" = "fullscreen toggle";

        "${modifier}+s" = "layout stacking";
        "${modifier}+t" = "layout tabbed";
        "${modifier}+p" = "layout toggle split";

        "${modifier}+f" = "floating toggle";
        "${modifier}+Shift+t" = "focus mode_toggle";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+l" = "swaylock";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+r" = "mode resize";

        "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy && ${playSoundScript}/bin/playNotificationSound";
        "Ctrl+Print" = "exec grim - | wl-copy && ${playSoundScript}/bin/playNotificationSound";

        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";

        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "${modifier}+0" = "workspace number 10";
        "${modifier}+Shift+0" = "move container to workspace number 10";
      } // (
        builtins.listToAttrs (builtins.map (x: { name = "${modifier}+${x}"; value = "workspace number ${x}"; }) (builtins.genList (x: toString (x + 1)) 9)) //
          builtins.listToAttrs (builtins.map (x: { name = "${modifier}+Shift+${x}"; value = "move container to workspace number ${x}"; }) (builtins.genList (x: toString (x + 1)) 9))
      );
    };
  };
}
