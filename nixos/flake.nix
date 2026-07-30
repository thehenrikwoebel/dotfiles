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
  };

  outputs = { self, nixpkgs, zscroll-src, nmrs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit zscroll-src; };
      modules = [
        ./configuration.nix
	{
		environment.systemPackages = [
			nmrs.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	}
      ];
    };
  };
}
