{ inputs, config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = builtins.readFile ./config.conf;

    settings = {

    "$mod" = "SUPER";
    /*
    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
    */
    };

    plugins = [
     # pkgs.hyprlandPlugins.hyprexpo
    ];
  };
   
}
