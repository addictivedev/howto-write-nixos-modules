let
  lib = import <nixpkgs/lib>;
in
lib.evalModules {
  modules = [
    ({ lib, ... }: {
      options.my_int = lib.mkOption {
        type = lib.types.int;
      };
    })

    ({ lib, ... }: {
      config.my_in = 2;
    })
  ];
}
