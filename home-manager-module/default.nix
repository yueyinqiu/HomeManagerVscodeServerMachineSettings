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

  config = lib.mkIf config.programs.vscode-server-machine-settings.enable (
    import ./config.nix {
      config = config;
      lib = lib;
      pkgs = pkgs;
    }
  );
}
