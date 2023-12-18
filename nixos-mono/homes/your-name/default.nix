# your home manager configuration
{
  imports = [
    ./git.nix
    ./i3.nix
    ./ssh.nix
    ./taskwarrior.nix
  ];

  home.stateVersion = "23.11";

}
