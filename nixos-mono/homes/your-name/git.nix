{ pkgs, ... }:
with pkgs;
{

  programs.git = {
    enable = true;
    userName = "Your-Name";
    userEmail = "your-name@example.com";
    signing = {
      key = "42AC51C9482D0834CF488AF1389EC2D64AC71EAC";
      signByDefault = true;
    };
    ignores = [
      "*.swp"
      "*~"
      ".idea"
      "result"
      ".envrc"
      ".direnv"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
    diff-so-fancy.enable = true;
  };

  home.packages = [
    pre-commit
    tig
    git-crypt
    gitAndTools.gitflow
    gitAndTools.gitSVN
    gitAndTools.git2cl
  ];

}
