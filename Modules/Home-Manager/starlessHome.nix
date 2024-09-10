{ inputs, config, pkgs, ... }:

{
  imports = [
    ./Gtk/gtk.nix
    ./Stylix/stylix.nix
    ./Hyprland/hyprland.nix
    ./Nixcord/nixcord.nix
    ./Vscode/vscode.nix
    ./Cava/cava.nix
    ./Kitty/kitty.nix
  ];
}