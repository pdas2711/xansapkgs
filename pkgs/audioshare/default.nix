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
		pipewire
	];
	installPhase = ''
		runHook preInstall
		mkdir -p $out/bin
		cp ./bin/as-cmd $out/bin/${pname}
		runHook postInstall
	'';
}
