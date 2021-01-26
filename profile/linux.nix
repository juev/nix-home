{ pkgs, ... }:
{

	# home.packages = with pkgs; [

	# ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
