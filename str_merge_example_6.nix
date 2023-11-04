let
  lib = import <nixpkgs/lib>;
in
lib.evalModules {
  modules = [
    ({ lib, ... }: {
      options =
        {
          strings = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
          };
        };
      config = {
        strings = {
          x = "foo";
        };
      };
    })

    ({ lib, ... }: {
      config =  {
        strings = {
          y = "bar";
        };
      };
    })
  ];
}
