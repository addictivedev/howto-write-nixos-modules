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
          };
        };
      config = lib.mkOptionDefault {
        strings = {
          x = "foo";
        };
      };
    })

    ({ lib, ... }: {
      config = lib.mkOptionDefault {
        strings = {
          y = "bar";
        };
      };
    })
  ];
}
