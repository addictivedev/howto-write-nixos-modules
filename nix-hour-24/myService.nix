{ lib, config, ... }: 
let
  cfg = options.services.myService;
in {
  options.services.myServices = {
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