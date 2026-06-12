My collection of nix flake templates

## Basic

A basic nix template to bootstrap a new nix related repository.

```shell
nix flake init --template github:mrvandalo/flake-templates
```

or

```shell
nix flake init --template github:mrvandalo/flake-templates#basic
```

### Updating

The template uses [flake-parts partitions](https://flake.parts/options/flake-parts-partitions) to keep CI and dev inputs lazy. This means there are three lock files to update:

```shell
nix flake update                # top-level: nixpkgs, flake-parts
(cd nix/ci && nix flake update) # CI partition: treefmt-nix
(cd nix/dev && nix flake update)# dev partition: devshell
```

## NixOS Mono Repository

Bootstrap your NixOS setup.

> It's a bit old and does not use nice nix flake tools like
> [flake-parts](https://flake.parts/) or
> [treefmt-nix](https://github.com/numtide/treefmt-nix)

```shell
nix flake init --template github:mrvandalo/flake-templates#nixos-mono
```
