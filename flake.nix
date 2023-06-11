{
  description = "Nix Configuration :D";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      ## TYPE:
      ##   genAttrs :: [ String ] -> (String -> Any) -> AttrSet
      ## E.G.
      ##   genAttrs [ "foo" "bar" ] (name: "x_" + name)
      ##   => { foo = "x_foo"; bar = "x_bar"; }
      forEachSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    in
    {

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      devShells = forEachSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system}; # {foo = <derivation>; ...}
        in
        import ./shell.nix { inherit pkgs; }
      );

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Main nixos configuration file <
            ./nixos/configuration.nix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "philopence@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ### DEBUG ###
            # {
            #   home.stateVersion = "22.11";
            #   home = {
            #     username = "philopence";
            #     homeDirectory = "/home/philopence";
            #   };
            # }
            # > Main home-manager configuration file <
            ./home-manager/home.nix
          ];
        };
      };
    };
}
