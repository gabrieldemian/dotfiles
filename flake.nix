{
  description = "Lombardo's multi user and multi hosts config.";

  inputs = {
    ## -- official nixos and HM --

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## -- utilities --

    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
    betterfox.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      catppuccin,
      ghostty,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      configLib = import ./lib { inherit lib; };

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
      specialArgs = {
        inherit
          inputs
          outputs
          nixpkgs
          configLib
          ;
      };
    in
    {
      # -- modules and stuff --
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # pkgs that can be built detachedly like:
      # nix build .#pixelcode
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );

      # overlays for nixpkgs pkgs, this is set in:
      #
      # `common/core/default.nix`
      #
      # and on the core of users homes.
      #
      # `home/gabriel/common/core/default.nix`
      overlays = import ./overlays { inherit inputs outputs; };

      # $ nix fmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # -- hosts --
      nixosConfigurations = {
        # my main
        legion = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/legion
          ];
        };
      };
    };
}
