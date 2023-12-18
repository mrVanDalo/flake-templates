{ pkgs, lib, config, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = ''
      default_border pixel
    '';
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      focus = {
        followMouse = true;
      };
      startup = [{ command = "${pkgs.albert}/bin/albert"; always = true; }];
      bars = [
        {
          #mode = "hide";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.home.homeDirectory}/.config/i3status-rust/config-blocks.toml";
          fonts.size = 10.0;
          trayOutput = "primary";
        }
      ];
    };
  };

  programs.i3status-rust = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings.font.size = lib.mkForce 6.5;
  };

}
