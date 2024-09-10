/*
  ___           __ _                    _   _          
 / __|___ _ _  / _(_)__ _ _  _ _ _ __ _| |_(_)___ _ _  
| (__/ _ \ ' \|  _| / _` | || | '_/ _` |  _| / _ \ '  \ 
 \___\___/_||_|_| |_\__, |\_,_|_| \__,_|\__|_\___/_||_|
                    |___/                              

*/

{ nixpkgs, config, pkgs, inputs, ... }:

let
  godot-beta = import ./Modules/NixOS/Godot/godot-beta.nix { inherit pkgs; };
in
{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    # Pass inputs to home-manager modules.
    extraSpecialArgs = { inherit inputs; };
    users.avery = import ./home.nix;
    backupFileExtension =  "dsfd";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

/*
 ___           _   
| _ ) ___  ___| |_ 
| _ \/ _ \/ _ \  _|
|___/\___/\___/\__|

*/

  boot = {

    # Kernel shit i dont understand.
    kernelPackages = pkgs.linuxPackages;
    kernelParams = ["quiet"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    ];

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    initrd.systemd.enable = true;

    # Loading screen theme.
    plymouth = {
      enable = true;
      /*themePackages = [
        pkgs.catppuccin-plymouth
      ];
      theme = "catppuccin-macchiato";*/
    };

  };



  networking.hostName = "avery"; # Define your hostname.
  # networking.wireless.enable = true;


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  programs.dconf.enable = true;
  programs.xfconf.enable = true;
  

  xdg.portal = {
    enable = true;
    #wlr.enable = true;
    extraPortals = with pkgs; [
    ];
  };

#wayland.windowManager.hyprland.plugins = [
#  inputs.hyprland-plugins.packages.${pkgs.system}.hycov
#  "/absolute/path/to/plugin.so"
#];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  console.keyMap = "uk";

  services = {

    xserver = {
      enable = true;
      xkb.layout = "gb";
      xkb.variant = "";
      desktopManager.gnome.enable = true;
    };

    displayManager.sddm = {
      enable = true;
      theme = "${import ./Modules/NixOS/Sddm/sddm-theme.nix { inherit pkgs; }}";
    };

    printing.enable = true;

    blueman.enable = true;

    flatpak.enable = true;

    gvfs.enable = true;

    # Audio.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
  };

  };
  # Configure console keymap

  hardware = {
    # Bluetooth.
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
      powerOnBoot = true;
    };

  };
  

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.avery = {
    isNormalUser = true;
    description = "Avery";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
  
    "electron-25.9.0"

  ];

  programs = {
    
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    wget
    firefox
    git
    gnome-2048
    adwsteamgtk

    ascii-image-converter
    neofetch
    nitch
    cbonsai
    fish
    zsh
    bash
    starship
    sl
    libsForQt5.qt5ct
    blueman
    neovim
    sqlite
    wlr-protocols

    swww
    waybar
    rofi
    libsForQt5.dolphin
    pcmanfm
    nwg-look
    grimblast
    swaynotificationcenter
    libnotify
    killall
    obs-studio
    gparted
    vintagestory

    obsidian
    aseprite
    lutris
    prismlauncher
    alvr
    appimage-run

    libsForQt5.qtstyleplugins
    libsForQt5.qtquickcontrols2
    libsForQt5.qtgraphicaleffects
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.lightly
    lightly-qt
    vimPlugins.lightline-gruvbox-vim
    lxqt.lxqt-policykit
    uxplay
    #glfw-wayland-minecraft
    direnv
    nautilus
    gnome-software
    rxvt-unicode
    pavucontrol
    wl-clipboard
    cliphist

    cpio
    meson
    cmake

    hyprlock
    hyprnome
    hyprpicker
    pyprland
    xwayland

    pipes
    gh-screensaver
    wf-recorder

    arrpc

    mesa
    nvidia-vaapi-driver
    vulkan-tools

    godot_4

  ] ++ [
    #godot-beta
  ];

  fonts = {
    packages = with pkgs; [
      roboto-mono
      jetbrains-mono
      jost
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      meslo-lgs-nf
    ];
    fontDir.enable = true;
  };
  
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    /* style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    }; */
  };

  stylix = {
    enable = true;

    image = ./image.jpg;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; # HAS to be set for some reason??

 
    
    targets = {
      console.enable = true;
      plymouth.enable = true;
    };

  };
  
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  #system.replaceRuntimeDependencies = [
  #  ({ original = pkgs.mesa; replacement = (import /srv/nixpkgs-mesa { }).pkgs.mesa; })
  #  ({ original = pkgs.mesa.drivers; replacement = (import /srv/nixpkgs-mesa { }).pkgs.mesa.drivers; })
  #];
  

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;	
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}