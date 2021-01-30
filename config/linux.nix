{ pkgs, ... }:
{

	# home.packages = with pkgs; [

	# ];

  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   # maxCacheTtlSsh = 36000;
  # };
  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    keys = [ "$HOME/.ssh/id_rsa_work" "$HOME/.ssh/deploy" ];
    agents = [ "ssh" ];
  };
}
