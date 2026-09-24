{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (import ./options.nix {
      lib = lib;
      pkgs = pkgs;
    })
  ];

  config = lib.mkIf config.home-manager-vscode-server-machine-settings.enable (
    import ./config.nix {
      config = config;
      lib = lib;
      pkgs = pkgs;
    }
  );
}
