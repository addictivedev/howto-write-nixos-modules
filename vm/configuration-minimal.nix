{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   #By default VMs will have a NIX_PATH configured for nix channels but no channel are downloaded yet. To avoid having to download a nix-channel every time the VM is reset, you can use the following nixos configuration
  #nix.nixPath = [
  #  "nixpkgs=${pkgs.path}"
  #];

  users.users.test = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.
    packages = with pkgs; [
      tree
    ];
    initialPassword = "test";
  };


  # Options for the screen
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      # Memory
      "-m 2048M"
    ];
  };

  # Enable ssh
  services.sshd.enable = true; 

  system.stateVersion = "23.05";

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };
}
