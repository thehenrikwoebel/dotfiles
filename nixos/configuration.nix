# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/zscroll.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # ssh agent 
  programs.ssh.startAgent = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Shell
  programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  ohMyZsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [ 
      	"git" 
      	"common-aliases" 
      ];
    };
  };
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; #x11 support
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

 services.keyd = {
  enable = true;
  keyboards.default = {
    ids = [ "*" ];
    settings = {
      "control+alt" = {
        "7" = "G-7";
        "8" = "G-8";
        "9" = "G-9";
        "0" = "G-0";
        "q" = "G-q";
        "rightbrace" = "G-rightbrace";
      };
    };
  };
}; 

  services.keyd.keyboards.corsair-mouse = {
  ids = [ "1b7e:1b1c" ];
  settings = {
    main = {
      "4" = "back";
      "3" = "forward";
    };
  };
};
  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  users.users."henrik" = {
    isNormalUser = true;
    description = "Henrik Wöbel";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	vim
	wget
	fastfetch
	kitty
	firefox
	git
	docker
	lazydocker
	thunderbird
	vscode
	libreoffice
	python3
	nodejs
	keyd
	waybar
	dunst
	rofi
	awww
	hyprpaper
	networkmanagerapplet
	hyprlauncher
	font-awesome
	btop
	inotify-tools
	psmisc
	nerd-fonts.jetbrains-mono
	playerctl
	python3Packages.setuptools
	ghostty
	hyprshot
	imv
	stow
	bluetui
	htop
	neovim
	oh-my-zsh
	zsh-syntax-highlighting
  	zsh-autosuggestions
	yazi
	evtest
  ];

  fonts.packages = with pkgs; [
	font-awesome
	nerd-fonts.symbols-only
	nerd-fonts.jetbrains-mono
  ];

  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than-30d";
  };

  # Git
  programs.git = {
  enable = true;
  config = {
    user = {
      name = "Henrik Wöbel";
      email = "henrik.woebel@gmail.com";
    };
    
    init.defaultBranch = "dev";
    
    pull.rebase = true;
    
    core.editor = "nvim";
    
    color.ui = true;
    
    push.autoSetupRemote = true;
    
    alias = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit -m";
      lg = "log --oneline --graph --decorate";
    };
  };
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
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
