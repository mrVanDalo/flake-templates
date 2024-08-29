{
  outputs = { self, ... }: {

    defaultTemplate = self.templates.basic;

    templates = {
      nixos-mono = {
        path = ./nixos-mono;
        description = "NixOS Mono Repository";
      };
      basic = {
        path = ./basic;
        description = "basic nix flake repository";
      };
    };
  };
}
