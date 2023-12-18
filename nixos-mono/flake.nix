{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixinate.url = "github:matthewcroughan/nixinate";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-legacy_2305.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    permown = {
      url = "github:mrVanDalo/module.permown";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { self
    , disko
    , home-manager
    , nixinate
    , nixos-hardware
    , nixpkgs
    , nixpkgs-legacy_2305
    , nixpkgs-unstable
    , permown
    , stylix
    }:
    let

      system = "x86_64-linux";
      inherit (nixpkgs) lib;

      meta = rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.permittedInsecurePackages = [ ];
          overlays = [
            (_self: _super: {
              unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
              legacy_2305 = nixpkgs-legacy_2305 { inherit system; };
            })
          ];
        };
        specialArgs = { };
      };

      createHomeManagerConfiguration = { name }:
        home-manager.lib.homeManagerConfiguration {
          inherit (meta) pkgs;
          modules = [
            #stylix.homeManagerModules.stylix
            #{ stylix.image = lib.mkDefault ./assets/wallpaper.png; }
            {
              imports = [ ./homes/${name} ];
              home.packages = [ home-manager.packages.${system}.home-manager ];
            }
          ];
        };

      # create machine configuration
      createNixosConfiguration =
        { name
        , host ? "${name}.private"
        , modules
        }:
        lib.nixosSystem {
          inherit (meta) system specialArgs pkgs;
          modules = modules ++
            defaultNixModules ++
            defaultNixOSModules ++
            [
              {
                # deployment tool nixinate
                _module.args.nixinate = {
                  host = host;
                  sshUser = "root";
                  buildOn = "remote"; # valid args are "local" or "remote"
                  substituteOnTarget = false; # if buildOn is "local" then it will substitute on the target, "-s"
                  hermetic = false;
                };
              }
              {
                imports = [
                  ./machines/${name}/configuration.nix
                ];
              }
            ];
        };

      defaultNixModules = [
        {
          # make flake inputs accessiable in NixOS
          _module.args.self = self;
          _module.args.inputs = self.inputs;
        }
        ({ pkgs, lib, ... }:
          {
            nix = {
              # no channels needed this way
              nixPath = [ "nixpkgs=${pkgs.path}" ];
              # make flakes available
              package = pkgs.nixUnstable;
              extraOptions = ''
                experimental-features = nix-command flakes
              '';
            };
          })
        { nix.settings.substituters = [ "https://cache.nixos.org/" ]; }
      ];

      defaultNixOSModules = [
        {
          boot.tmp.useTmpfs = lib.mkDefault true;
          imports = [
            permown.nixosModules.permown
            disko.nixosModules.disko
          ];
        }
        {
          imports = [ home-manager.nixosModules.home-manager ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ ];
        }
      ];

    in
    {

      # home manager configurations
      homeConfigurations = {
        your-name = createHomeManagerConfiguration { name = "your-name"; };
      };

      # nixos configurations
      nixosConfigurations =
        {
          primus = createNixosConfiguration {
            name = "primus";
            host = "primus.example.com";
            modules = [
              # nixos-hardware.nixosModules.lenovo-thinkpad-x220
              { home-manager.users.your-name = import ./nixos/homes/your-name; }
            ];
          };
        };
    };
}






