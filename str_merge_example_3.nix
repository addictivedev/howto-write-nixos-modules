let
  lib = import <nixpkgs/lib>;
in
lib.evalModules {
  modules = [
    ({ lib, ... }: {
      options =
        {
          strings = lib.mkOption {
            type = lib.types.attrsOf lib.types.lines;
            default = {
              x = "foo";
            };
          };
        };
    })

    ({ lib, ... }: {
      config.strings = lib.mkOptionDefault {
        x = "bar";
      };
    })
  ];
}
