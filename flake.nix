{
  outputs = { ... }: {
    templates = {
      nixos-mono = {
        path = ./nixos-mono;
        description = "NixOS Mono Repository";
      };
    };
  };
}
