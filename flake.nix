{
  description = "Home Manager module for managing VS Code Server machine settings";

  outputs = { self }: {
    homeManagerModules = {
      default = import ./home-manager-module;
      home-manager-vscode-server-machine-settings = import ./home-manager-module;
    };
  };
}
