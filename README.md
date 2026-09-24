# HomeManagerVscodeServerMachineSettings

Home Manager module for managing the VS Code Server
[machine settings](https://code.visualstudio.com/docs/remote/ssh#_machine-settings) at
`~/.vscode-server/data/Machine/settings.json`.

When connecting to a remote host via VS Code Remote-SSH, the `Machine`
scope settings apply to that machine independently of the local VS Code
installation. This module lets you declare them declaratively with Home
Manager.

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager-vscode-server-machine-settings.url = "github:yueyinqiu/HomeManagerVscodeServerMachineSettings";
  };

  outputs = { nixpkgs, home-manager, home-manager-vscode-server-machine-settings, ... }:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations.alice = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          home-manager-vscode-server-machine-settings.homeManagerModules.home-manager-vscode-server-machine-settings
          {
            home.username = "alice";
            home.homeDirectory = "/home/alice";
            home.stateVersion = "26.05";

            home-manager-vscode-server-machine-settings = {
              enable = true;
              settings = {
                "editor.formatOnSave" = true;
                "files.autoSave" = "off";
                "terminal.integrated.shellIntegration.enabled" = false;
              };
            };
          }
        ];
      };
    };
}
```

## Options

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `enable` | bool | `false` | Whether to enable the module |
| `mutableUserSettings` | bool | `false` | Merge declared settings into an existing `settings.json`, preserving manual changes |
| `dataFolderName` | str | `".vscode-server"` | VS Code Server data folder inside the home directory |
| `settings` | JSON object or path | `{ }` | Settings written to `data/Machine/settings.json` |

## Mutable settings

By default (`mutableUserSettings = false`), `settings.json` is symlinked to a
store path and fully managed by Home Manager. Any changes made by VS Code
Server or by hand are discarded on the next activation.

With `mutableUserSettings = true`, the declared `settings` are merged into the
existing `settings.json` at activation time instead, so changes made outside
Home Manager are preserved. Declared settings take precedence, and the existing
file may contain comments or trailing commas (JSONC), which are parsed
leniently before merging.

```nix
home-manager-vscode-server-machine-settings = {
  enable = true;
  mutableUserSettings = true;
  settings = {
    "editor.formatOnSave" = true;
  };
};
```

---

All documentation and `description` fields in this repository are AI-generated.
