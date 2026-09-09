{
	description = "xwpkgs - custom nix derivations for packaging software";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		audioshare = {
			url = "https://github.com/mkckr0/audio-share/releases/download/v0.3.4/audio-share-server-cmd-linux.tar.gz";
			flake = false;
		};
		pomo = {
			url = "git+https://github.com/Bahaaio/pomo.git";
			flake = false;
		};
	};

	outputs = { nixpkgs, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		packages.${system} = {
			audioshare = pkgs.callPackage ./pkgs/audioshare/default.nix { src = inputs.audioshare; };
			pomo = pkgs.callPackage ./pkgs/pomo/default.nix { src = inputs.pomo; };
		};
	};
}
