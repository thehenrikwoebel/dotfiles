{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zscroll-src = {
      url = "github:noctuid/zscroll";
      flake = false;
    };
    nmrs = {
      url = "github:networkmanager-rs/nmrs-gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zscroll-src, nmrs, zen-browser, home-manager, ... }:
    let
      system = "x86_64-linux";

      # Konfigurierter pkgs-Import inkl. system & allowUnfree (ideal für Home Manager)
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit zscroll-src nmrs zen-browser; };
        modules = [
          ./configuration.nix
          {
            # Aktiviert un-freie Pakete direkt für die NixOS-Instanz
            nixpkgs.config.allowUnfree = true;

            environment.systemPackages = [
              nmrs.packages.${system}.default
              zen-browser.packages.${system}.default
            ];
          }
        ];
      };

      homeConfigurations.henrik = home-manager.lib.homeManagerConfiguration {
        # Nutzt das oben definierte pkgs (inkl. allowUnfree)
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
