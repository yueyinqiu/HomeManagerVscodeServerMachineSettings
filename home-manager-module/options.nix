{
  config,
  lib,
  pkgs,
}:

let
  jsonFormat = pkgs.formats.json { };
in
{
  options.home-manager-vscode-server-machine-settings = {
    enable = lib.mkEnableOption "VS Code Server machine settings";

    mutable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether the machine `settings.json` should be mutable.

        When `false` (the default), the file is symlinked to a store path and
        managed entirely by Home Manager.

        When `true`, the declared {option}`settings` are merged into the
        existing `settings.json` at activation time, preserving any changes
        made manually or by VS Code Server itself. Declared settings take
        precedence over existing ones. The existing file may contain JSON with
        comments (JSONC); it is parsed leniently before merging.
      '';
    };

    settingsPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.vscode-server/data/Machine/settings.json";
      description = ''
        Absolute path to the machine `settings.json` to manage.

        This defaults to VS Code Server's standard location. Override it if
        you have customised `remote.SSH.serverInstallPath` or moved the server
        data folder.
      '';
    };

    settings = lib.mkOption {
      type = lib.types.either lib.types.path jsonFormat.type;
      default = { };
      example = {
        "editor.formatOnSave" = true;
        "files.autoSave" = "off";
        "terminal.integrated.shellIntegration.enabled" = false;
      };
      description = ''
        Configuration written to {option}`settingsPath`.
        This can be a JSON object or a path to a custom JSON file.
      '';
    };
  };
}
