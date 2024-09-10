{ inputs, config, pkgs, ... }:

{
  imports = [
    ./Modules/Home-Manager/starlessHome.nix
    inputs.nixcord.homeManagerModules.nixcord
  ];
  
  # user info
  home = {
    username = "avery";
    homeDirectory = "/home/avery";
    stateVersion = "23.11"; # Dont change this you dumbass avery.
  };


  programs.home-manager.enable = true;
}


