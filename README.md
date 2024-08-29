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

## NixOS Mono Repository

Bootstrap your NixOS setup.

> It's a bit old and does not use nice nix flake tools like
> [flake-parts](https://flake.parts/) or
> [treefmt-nix](https://github.com/numtide/treefmt-nix)

```shell
nix flake init --template github:mrvandalo/flake-templates#nixos-mono
```
