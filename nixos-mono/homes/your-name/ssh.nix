{
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = [ pkgs.sshuttle ];
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/palo_rsa.pub";
        identitiesOnly = true;
      };
      "github.com" = {
        hostname = "ssh.github.com";
        user = "root";
      };
      # use aws session manager
      #"*.compute.amazonaws.com".extraOptions = {
      #  ProxyCommand = ''
      #    sh -c "${pkgs.awscli2}/bin/aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
      #  '';
      #};
    };
  };
}
