# home.nix
{ pkgs, ... }:
{
  home.username = "henrik";
  home.homeDirectory = "/home/henrik";
  home.stateVersion = "24.05";

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.formatOnSave" = true;
    };
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      eamodio.gitlens
      dart-code.flutter
      ms-python.python
      ms-azuretools.vscode-docker
      vscodevim.vim
      aaron-bond.better-comments
    ];
  };
}
