# Structure

- homes: contains home manager configuration of every user.
- machines: contains nixos configurations for every machine.
- flake.nix: contains all the nix configuration. Entry point for everything.
- flake.lock: dependency lock file.

# How to see configurations

> don't forget to make nix use flakes [https://nixos.wiki/wiki/Flakes](https://nixos.wiki/wiki/Flakes)
 
```
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

```shell
nix flake show
```

# Home Manager

## How to build (and check) home-manager configurations

```shell
home-manager --flake . build
```

## How to apply home-manager configurations

```shell
home-manager --flake .
```

# Nixinate

## Deploy machine

```shell
nix run .#apps.nixinate.primus-dry-run
nix run .#apps.nixinate.primus
```
