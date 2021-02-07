{ pkgs, ... }:
{

	home.packages = with pkgs; [
		imagemagick
		qrencode
		unixtools.watch
	];

	programs.git.extraConfig.credential.helper = "osxkeychain";

}
