{
  description = "mrvandalos nix flake templates";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/formatter.nix
      ];
      systems = [ "x86_64-linux" ];
      flake = {

        defaultTemplate = self.templates.basic;

        templates = {
          nixos-mono = {
            path = ./nixos-mono;
            description = "NixOS Mono Repository";
          };
          basic = {
            path = ./basic;
            description = "Basic Nix Flake Repository";
          };
        };
      };
    };
}
