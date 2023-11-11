{ pkgs ? import <nixpkgs> {} }:  
pkgs.nixosTest {
  name = "myService";
  nodes = {
    machine = {
      imports = [
        ./myService.nix
      ];

      services.myService.enable = true;
      services.myService.passwordFile = "/root/mySecretKey";

      systemd.services.mySecretGenerator = {
        wantedBy = [ "multi-user.target" ];
        before = [ "myService.service" ];
        script = ''
          ${pkgs.pwgen}/bin/pwgen 20 1 > /root/mySecretKey 
        '';
      };
    };
  };

  testScript = ''
    #### PYTHON CODE for TESTING###
    # we start all the machines
    start_all()

    # wait for the systemd unit on the node "machine"
    machine.wait_for_unit("myService.service")

    # we grep the log message that we expect
    machine.succeed("journalctl -u myService.service --grep='The secret is:'")
  '';
}
