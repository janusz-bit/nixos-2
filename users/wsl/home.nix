{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.nixos = {

    programs.git = {
      enable = true;
      settings = {
        user.name = "janusz-bit";
        user.email = "janusz-bit@proton.me";
        init.defaultBranch = "main";
      };
    };
    programs.gh.enable = true;

  };
  home-manager.backupFileExtension = "backup";
  home-manager.users.nixos.home.stateVersion = "25.05";
}
