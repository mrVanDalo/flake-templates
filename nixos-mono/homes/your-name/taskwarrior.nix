{ pkgs, ... }:
{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256.theme";
    config = {
      rc.color = "off";
      report.active.filter = "+PENDING and ( +ACTIVE or +DUETODAY or +TODAY or +OVERDUE )";
      report.active.columns = [ "id" "start" "entry.age" "priority" "project" "due" "description" ];
      report.active.labels = [ "ID" "Started" "Age" "Priority" "Project" "Due" "Description" ];
    };
  };
}