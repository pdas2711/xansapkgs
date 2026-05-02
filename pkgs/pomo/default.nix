{ stdenv, pkgs, lib, src, ... }: pkgs.buildGo125Module rec {
	pname = "pomo";
	version = "latest";
	name = "${pname}-${version}";
	inherit src;
	modRoot = ".";
	vendorHash = "sha256-kbTYq4Xc86bcmNMhInq1rwYTbGRmu2TEXT2e7bqT5YY=";
}
