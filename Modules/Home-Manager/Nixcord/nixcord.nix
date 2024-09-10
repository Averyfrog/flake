{ inputs, config, pkgs, ... }:

{
  programs.nixcord = {
    enable = true;  # enable Nixcord. Also installs discord package
    quickCss = ''@import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");'';  # quickCSS file
    vesktop.enable = true;
    discord.enable = false;
    config = {
      useQuickCss = true;   # use out quickCSS
      frameless = true; # set some Vencord options
      plugins = {
        alwaysAnimate.enable = true;
        callTimer.enable = true;
        disableCallIdle.enable = true;
        webScreenShareFixes.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        petpet.enable = true;
        betterFolders.enable = true;
        pinDMs.enable = true;
        messageLogger.enable = true;
        webRichPresence.enable = true;
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };

  /*
  xdg.desktopEntries = {
    nixcord = {
      name = "Nixcord";
      genericName = "Internet Messenger";
      exec = "vesktop %U";
      terminal = false;
      categories = [ "InstantMessaging" "Network" "Chat" ];
      mimeType = [ "Application" ];
      Icon = ./nixcord.png
    };
  };
  */
}

