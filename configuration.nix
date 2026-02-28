# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
#
{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # include NixOS-WSL modules

  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vscode.fhs
    micro
    zed-editor-fhs
    nil
    nixd
  ];

  # programs.git = {
  #   enable = true;
  #   config = {
  #     user.name = "janusz-bit";
  #     user.email = "janusz-bit@proton.me";
  #     init.defaultBranch = "main";
  #     url = {
  #       "https://github.com/" = {
  #         insteadOf = [
  #           "gh:"
  #           "github:"
  #         ];
  #       };
  #     };
  #   };
  #
  # };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
