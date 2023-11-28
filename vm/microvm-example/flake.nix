{
  description = "NixOS in MicroVMs";

  inputs.microvm.url = "github:astro/microvm.nix";
  inputs.microvm.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, microvm }:
    let
      system = "x86_64-linux";
    in {
      defaultPackage.${system} = self.packages.${system}.qemu;

      packages.${system} = {
        default = self.packages.${system}.qemu;
        qemu = self.nixosConfigurations.qemu-microvm.config.microvm.declaredRunner;
        chv = self.nixosConfigurations.chv-microvm.config.microvm.declaredRunner;
      };

      nixosConfigurations = {
        qemu-microvm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            {
              networking.hostName = "qemu-microvm";
              users.users.root.password = "";
              microvm = {
                volumes = [ {
                  mountPoint = "/var";
                  image = "var.img";
                  size = 256;
                } ];
                shares = [ {
                  # use "virtiofs" for MicroVMs that are started by systemd
                  proto = "9p";
                  tag = "ro-store";
                  # a host's /nix/store will be picked up so that no
                  # squashfs/erofs will be built for it.
                  source = "/nix/store";
                  mountPoint = "/nix/.ro-store";
                } ];

                hypervisor = "qemu";
                socket = "name.socket";
              };
            }
          ];
        };

        # cloud-hypervisor example
        chv-microvm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            {
              networking.hostName = "chv-microvm";
              users.users.root.password = "";
              microvm = {
                volumes = [ {
                  mountPoint = "/var";
                  image = "var.img";
                  size = 256;
                } ];
                shares = [ {
                  # use "virtiofs" for MicroVMs that are started by systemd
                  proto = "virtiofs";
                  tag = "ro-store";
                  # a host's /nix/store will be picked up so that no
                  # squashfs/erofs will be built for it.
                  source = "/nix/store";
                  mountPoint = "/nix/.ro-store";
                } ];

                hypervisor = "cloud-hypervisor";
                socket = "name.socket";
              };
            }
          ];
        };

      };
    };
}
