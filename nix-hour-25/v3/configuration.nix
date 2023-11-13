{ pkgs, lib, config, ... }: {
  options.slashBinPackages = lib.mkOption {
    type = lib.types.attrsOf lib.types.package;
    default = {};
  };

  config.system.activationScripts.slashBin = ''
    mkdir -p /bin
    ${lib.concatStrings (lib.mapAttrsToList (name: package: ''
      for bin in ${lib.getBin package}/bin/*; do
        ln -s "$bin" /bin/$(basename "$bin")
      done 
    '') config.slashBinPackages)}
  '';
}
