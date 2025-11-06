{
  description = "Model Context Protocol (MCP) server for Slack Workspaces";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays.default = final: prev: {
        slack-mcp-server = final.callPackage ./package.nix { };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          default = self.packages.${system}.slack-mcp-server;

          slack-mcp-server = pkgs.callPackage ./package.nix { };
        };

        apps = {
          default = self.apps.${system}.slack-mcp-server;

          slack-mcp-server = {
            type = "app";
            program = "${self.packages.${system}.slack-mcp-server}/bin/slack-mcp-server";
          };
        };
      }
    );
}
