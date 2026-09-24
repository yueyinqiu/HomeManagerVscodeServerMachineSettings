{
  lib,
  pkgs,
}:

let
  jsonFormat = pkgs.formats.json { };
in
{
  options.home-manager-vscode-server-machine-settings = {
    enable = lib.mkEnableOption "VS Code Server machine settings";

    mutableUserSettings = lib.mkOption {
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

    dataFolderName = lib.mkOption {
      type = lib.types.str;
      default = ".vscode-server";
      description = ''
        Name of the VS Code Server data folder inside the home directory.
        This is typically {file}`.vscode-server`.
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
        Configuration written to the VS Code Server's machine
        {file}`settings.json` at
        {file}`<home>/{option}`dataFolderName`/data/Machine/settings.json`.
        This can be a JSON object or a path to a custom JSON file.
      '';
    };
  };
}
