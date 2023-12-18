{ pkgs, ... }:
{
  # packages I like to be insalled
  home.packages = [
    pkgs.htop
    pkgs.vscode
    pkgs.curl
    pkgs.wget
    pkgs.gojq
    pkgs.jq
    pkgs.ijq
  ];
}
