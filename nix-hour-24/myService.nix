{ lib, config, ... }: 
let
  cfg = config.services.myService;
in {
  options.services.myService = {
    enable = lib.mkEnableOption "myService";
  };

  config = lib.mkIf cfg.enable {
    systemd.services.myService = {
      wantedBy = [ "multi-user.target" ];
      script = ''
        while true; do
          echo foo
        done
      '';
    };
  };
}
