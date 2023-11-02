let
  lib = import <nixpkgs/lib>;
in
lib.evalModules {
  modules = [
    ({ lib, ... }: {
      options =
        {
          string = lib.mkOption {
            type = lib.types.string;
            default = {
              foo = "foo";
            };
          };
        };
    })

    ({ lib, ... }: {
      config.string = "hello";
    })
  ];
}
