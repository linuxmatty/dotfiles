{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "matty-stolni"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_AT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment & Hyprland and i3 window managers.
  services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  # Enable natural scrolling by default
  services.xserver.libinput.naturalScrolling = true;

  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true; # zsh-autosuggestions plugin
    syntaxHighlighting = {
      enable = true; # zsh-syntax-highlighting plugin
      highlighters = [ "main" ];
    };
    ohMyZsh = {
      enable = true;
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  # Set Zsh as the default user shell
  users.defaultUserShell = pkgs.zsh;

# Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cz";
    variant = "dvorak-ucw";
  };

  # Configure console keymap
  console.keyMap = "cz-lat2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matty = {
    isNormalUser = true;
    description = "Matyáš Jan Kudláček";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #	thunderbird
	
    ];
  };

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	pkgs.neovim
  	wget
	pkgs.brave
	pkgs.steam
	pkgs.flatpak
	pkgs.gnome.gdm
	pkgs.htop
	pkgs.neofetch
	pkgs.alacritty
	pkgs.zsh
	pkgs.oh-my-zsh
	pkgs.zsh-syntax-highlighting
	pkgs.meslo-lgs-nf
	pkgs.zsh-powerlevel10k
	pkgs.font-awesome
	pkgs.git
	pkgs.libinput
	pkgs.discord

	pkgs.python3
	pkgs.python312Packages.pip
	pkgs.qtile
	python312Packages.qtile-extras
	pkgs.rofi
	pkgs.lxde.lxsession
	pkgs.picom
	pkgs.networkmanagerapplet
	pkgs.conky

	pkgs.gnumake
	pkgs.unzip
	pkgs.libgcc
	pkgs.ripgrep
	pkgs.xclip
	pkgs.libgccjit
	pkgs.asciidoc-full-with-plugins
	pkgs.haskellPackages.commonmark-cli
	pkgs.marp-cli
	pkgs.gimp
	pkgs.nitrogen
  ];

   # Deal with Nvidia's shit
     
     # Enable OpenGL
     hardware.opengl = {
       enable = true;
       driSupport = true;
       driSupport32Bit = true;
     };

     # Load nvidia driver for Xorg and Wayland
     services.xserver.videoDrivers = ["nvidia"];

     hardware.nvidia = {
       modesetting.enable = true; # required
       powerManagement.enable = false; # experimental, can cause sleep/suspend to stop working
       powerManagement.finegrained = false;
       open = false; # not supported by gpu
       nvidiaSettings = true;
       package = config.boot.kernelPackages.nvidiaPackages.stable;
     };

#    hardware.nvidia.prime = {
#      sync.enable = true;
#      nvidiaBusId = "PCI:01:00.0";
 #   };

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
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
