{ pkgs, ... }:
{

	home.packages = with pkgs; [

		qrencode
		coreutils
		imagemagick
		unixtools.watch

	];

	programs.alacritty.enable = true;
	programs.git.extraConfig.credential.helper = "osxkeychain";

}
