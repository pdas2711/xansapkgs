{
	description = "Linux Server to share audio with Android client";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		audioshare = {
			url = "https://github.com/mkckr0/audio-share/releases/download/v0.3.4/audio-share-server-cmd-linux.tar.gz";
			flake = false;
		};
	};

	outputs = { nixpkgs, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		packages.${system}.default = pkgs.callPackage ./default.nix { inherit inputs; };
	};
}
