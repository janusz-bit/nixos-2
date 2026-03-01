{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    # https://flake.parts/module-arguments.html
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        # debug = true;
        imports = [
          # Optional: use external flake logic, e.g.
          # inputs.foo.flakeModules.default
          inputs.home-manager.flakeModules.home-manager
        ];
        flake = {
          # Put your original flake attributes here.
          nixosConfigurations = {
            nixos = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                inputs.nixos-wsl.nixosModules.default
                ./configuration.nix
                ./wsl.nix
                inputs.home-manager.nixosModules.default
                ./hosts/wsl/home.nix
              ];
            };
          };

          homeModules.nixos =
            { ... }:
            {
              home.username = "nixos";
              home.homeDirectory = "/home/nixos";
              home.stateVersion = "25.05";
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
          homeConfigurations.nixos = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
            modules = [
              inputs.self.homeModules.nixos
            ];

          };
        };
        systems = [
          # systems for which you want to build the `perSystem` attributes
          "x86_64-linux"
          # ...
        ];
        perSystem =
          { config, pkgs, ... }:
          {

            # Recommended: move all package definitions here.
            # e.g. (assuming you have a nixpkgs input)
            # packages.foo = pkgs.callPackage ./foo/package.nix { };
            # packages.bar = pkgs.callPackage ./bar/package.nix {
            #   foo = config.packages.foo;
            # };
          };
      }
    );
}
