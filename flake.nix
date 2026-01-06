{
	description = "Share audio between PC and Android";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		audioshare = {
			url = "github:mkckr0/audio-share";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, ... }@inputs:
	let
		allSystems = [ "x86_64-linux" ];
		forAllSystems = f: nixpkgs.lib.genAttrs allSystems (
			system:
			f {
				pkgs = import nixpkgs { inherit system; };
			}
		);
	in {
		packages = forAllSystems ({ pkgs }: {
			default =
			let
				binName = "audioshare";
			in
				pkgs.stdenv.mkDerivation {
					pname = "audioshare";
					version = "0.3.4";
					src = inputs.audioshare;
					nativeBuildInputs = with pkgs; [
						cmake
						pkg-config
					];
					buildInputs = with pkgs; [
						vcpkg
						asio
						protobufc
						cxxopts
						spdlog
					];
					buildPhase = ''
						cmake --preset linux-Release
						cmake --build --preset linux-Release
					'';
					installPhase = ''
						mkdir -p $out/bin
						cp out/install/linux-Release/bin/as-cmd $out/bin/${binName}
					'';
					env = {
						VCPKG_TARGET_TRIPLET = "x64-linux";
						VPCKG_ROOT = ".";
					};
				};
		});
	};
}
