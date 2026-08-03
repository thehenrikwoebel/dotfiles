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
  };

  outputs = { self, nixpkgs, zscroll-src, nmrs, zen-browser, ... }: 
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit zscroll-src nmrs zen-browser; };
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            environment.systemPackages = [
              nmrs.packages.${system}.default
	      zen-browser.packages.${system}.default
            ];
          })
        ];
      };
    };
}
