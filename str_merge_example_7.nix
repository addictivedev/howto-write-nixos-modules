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
          x = lib.mkDefault "foo";
        };
      };
    })

    ({ lib, ... }: {
      config =  {
        strings = {
          x = "baz";
          y = "bar";
        };
      };
    })
  ];
}
