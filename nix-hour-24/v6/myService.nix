{ lib, config, pkgs, ... }: 
let
  cfg = config.services.myService;
in {
  options.services.myService = {
    enable = lib.mkEnableOption "myService";

    passwordFile = lib.mkOption {
      type = lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.myService = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.bash ];
      script = ''
        ${./myScript.sh} "$CREDENTIALS_DIRECTORY/password";
      '';
      serviceConfig.DynamicUser = true;
      serviceConfig.LoadCredential = [ "password:${cfg.passwordFile}" ];
    };
  };
}
