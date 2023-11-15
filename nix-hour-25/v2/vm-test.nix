{ pkgs ? import <nixpkgs> {} }:  
pkgs.nixosTest {
  name = "myService";
  nodes = {
    machine = {
      imports = [
        ./module.nix
      ];
    };
  };

  testScript = ''
    #### PYTHON CODE for TESTING###
    # we start all the machines
    start_all()

    machine.succeed("test -e /bin/gcc")
    #machine.fail("test -e /bin/hello2")
  '';
}
