{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.nixos = {

    programs = {
      gh.enable = true;
      git = {
        enable = true;
        settings = {
          user.name = "janusz-bit";
          user.email = "janusz-bit@proton.me";
          init.defaultBranch = "main";
        };

      };
    };

  };
  home-manager.backupFileExtension = "backup";
  home-manager.users.nixos.home.stateVersion = "25.05";
}
