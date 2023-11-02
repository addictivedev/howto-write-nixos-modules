let
  lib = import <nixpkgs/lib>;
in
lib.evalModules {
  modules = [
    ({ lib, ... }: {
      options =
        {
          ints = lib.mkOption {
            type = lib.types.attrsOf lib.types.int;
          };
          strings = lib.mkOption {
            type = lib.types.attrsOf lib.types.string;
            default = {
              x = "foo";
            };
          };
        };
    })
  ];
}
