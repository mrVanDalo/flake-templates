# your home manager configuration
{
  imports = [
    ./git.nix
    #./i3.nix
    ./ssh.nix
    ./taskwarrior.nix
  ];

  home.username = "your-name";
  home.homeDirectory = "/home/your-name";

  home.stateVersion = "23.11";

}
