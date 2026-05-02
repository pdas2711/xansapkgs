{ stdenv, pkgs, src, ... }: stdenv.mkDerivation rec {
	pname = "audioshare";
	version = "0.3.4";
	name = "${pname}-${version}";
	inherit src;
	nativeBuildInputs = with pkgs; [
		autoPatchelfHook
	];
	buildInputs = with pkgs; [
		gcc
		asio
		protobuf
		cxxopts
		spdlog
	];
	installPhase = ''
		mkdir -p $out/bin
		cp out/install/linux-Release/bin/as-cmd $out/bin/${pname}
	'';
}
