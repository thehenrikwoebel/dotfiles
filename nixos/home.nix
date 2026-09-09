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
      "python.languageServer" = "Pylance";
    };
    profiles.default.extensions = with pkgs.vscode-extensions; [
		ms-python.python
		ms-python.vscode-pylance
		aaron-bond.better-comments
		dart-code.dart-code
		ms-azuretools.vscode-docker
		dart-code.flutter
		eamodio.gitlens
		jnoortheen.nix-ide
		vscodevim.vim
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    
    stdlib = ''
      use_devenv() {
        watch_file devenv.nix
        watch_file devenv.yaml
        watch_file devenv.lock
        eval "$(devenv print-dev-env)"
      }
    '';
  };
}
