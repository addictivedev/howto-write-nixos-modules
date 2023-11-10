{ lib, config, pkgs, ... }: 
let
  cfg = config.services.myService;
in {
  options.services.myService = {
    enable = lib.mkEnableOption "myService";

    password = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.myService = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.bash ];
      serviceConfig.ExecStart = "${./myScript.sh} ${cfg.password}";
    };
  };
}
