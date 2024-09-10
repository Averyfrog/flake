{ inputs, config, pkgs, ... }:

let
 gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; }; # Incase i wanna use gruvbox icons or smthn.
in
{
  gtk = {
    enable = true;
    /*
    theme = {
      name = "catppuccin-mocha-yellow-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "yellow" ];
        size = "compact";
        #tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    */
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "yellow";
      };
      name = "Papirus-Dark";
    };
  };
  # home.sessionVariables.GTK_THEME = "adw-gtk3";
}