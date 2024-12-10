{ inputs, ... }:
{

  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { pkgs, self', ... }:
    {
      devshells.default = {

        commands = [
          {
            help = "example command";
            name = "example";
            command = "echo 'this is an example command'";
          }
        ];

        packages = [
          # packages used in commands or in devshell
        ];
      };
    };
}
