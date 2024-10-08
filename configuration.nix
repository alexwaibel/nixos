# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  virtualisation.docker.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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
  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "systemd-journal" "docker" ];
    packages = with pkgs; [
    	gnome.gnome-remote-desktop
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtaVhLcAEGvSMnXER122dciG0HQyZG4SPxAGT6goELzh3Oobd4dZn/Rj2dbrTZKe6SBLQyii3EEnSUwhBEF3qGWcnmK9TLdNG2M/mS/w9A0JDY9epE0ngp1k5qkTHs/U3FxXz8ZrmtN65rwO1Wjw+frfS8pao12i5kvEVP5G+bqqXPhQg6XnggV88X3nM/a95dYb8OF4ko+3hVus6LKh00lzBfFdtLNbE04Pd9lFWpb6gQHUxM0PQr9nU4dNkIYQmoarhTkPd5YBO8UbBukbRLeviz/rwN330UjRWchZykrMwwHxFf4HuWpIwQNsQ+Bus6QKiz4erSgq6BHgAETS3dRyWFWVmY/TkC239BFWHoAoVXVHIgegwks42Wa7H2ViVKqWbkzq9cV7GRr4Lu1d32nE0a9hAS8aXo80AoUPFohasVRXttifwD9PwHs3Sf0Ki4x4YdFb3UagEgKfFM37qnd0mg/u6g7U41P0BSRXRvU5B3aClOFp+BabJ/EORB63M= alex"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBPRVJQgIcbFhkCNG7sYU4GqbKIct6I23uB21fsb8EHcoUFNc6j6mY7Yc5mrrx2qJjIo+qpbOPXPav54nzMp/woEktk+mSeqvUhHqi8yZgA8/Xs5qqZbn1QxF14G5V9tn05e56/9MyOdRCs0PYzt+gTYKsu90ffnA//zECF1SU7XDGAYgOjufgfEQxoPQX9HylMzuC4Wcb0tCJZ68aYC3SytCg8a/Vx4gMndodm4c/ikcrTpEb6D8JctTfuRMgNPnqAaJv3SAXd1lmFaPUgPR6iAaVfTnf1x0QphMkmAaAuDYZ9MHIwqFVIpw531RA6NQuVtPGjtQXdtFj7GOcsygV3AVfnV3eNFBQ/altuioGlks+yQHSpH/CqNTEHPx90YS4ALzhXiipt9uF1aq21LmyyturRgdCcr3gROl/A50/ga+WlLqXytmwqkWc5rQ2O4nWXtOIHgqAV7Kl6OtqUdFJk1DtRom2tPj+0DCXN1vFzFcNe389b1a1KpSE2rbIXj8= alex@alex-ThinkPad-X1-Yoga-4th"
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Enable QEMU guest agent.
  services.qemuGuest.enable = true;

  # Enable RDP server
  services.gnome.gnome-remote-desktop.enable = true;
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "gmone-remote-desktop";
  services.xrdp.openFirewall = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3389 ];
    allowedUDPPorts = [ 3389 ];
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
