{ pkgs ? import <nixpkgs> {} }:  
pkgs.nixosTest {
  name = "myService";
  nodes = {
    machine = {
      imports = [
        ./myService.nix
      ];

      services.myService.enable = true;
      services.myService.enable = "ThisIsMyPassword"
    };
  };

  testScript = ''
    #### PYTHON CODE for TESTING###
    # we start all the machines
    start_all()

    # wait for the systemd unit on the node "machine"
    machine.wait_for_unit("myService.service")

    # we grep the log message "foo" that we expect
    machine.succeed("journalctl -u myService.service --grep='ThisIsMyPassword'")
  '';
}
