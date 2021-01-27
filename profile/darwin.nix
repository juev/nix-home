{ pkgs, ... }:
{

	home.packages = with pkgs; [
		coreutils
		imagemagick
		qrencode
		unixtools.watch
		bashInteractive_5
		vscode
	];

	programs.git.extraConfig.credential.helper = "osxkeychain";

}
