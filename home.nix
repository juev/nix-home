{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "d.evsyukov";
  home.homeDirectory = "/Users/d.evsyukov";

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.direnv.enable = true;
  programs.dircolors.enable = true;

  # git with initial configration:wq
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Denis Evsyukov";
    userEmail = "denis@evsyukov.org";
    ignores = [ 
      "*~"
      ".DS_Store"
      ".vscode"
      ".envrc"
      ".python-version"
      ".idea"
      "*.iml"
    ];
  };

  # enable autojump https://github.com/wting/autojump
  programs.autojump.enable = true;

  home.packages = [
    pkgs.vim
    pkgs.age
    pkgs.autojump
    pkgs.bash
    # pkgs.direnv
    pkgs.emacs
    pkgs.fortune
    # pkgs.git
    pkgs.gnupg
    pkgs.hledger
    pkgs.jq
    pkgs.mc
    pkgs.mosh
    pkgs.ripgrep
    pkgs.rustup
    # pkgs.tmux
    pkgs.tree
    pkgs.go
    pkgs.curl
    pkgs.gettext
    # pkgs.htop
    pkgs.terraform
    pkgs.coreutils
    pkgs.hugo
    pkgs.upx
    pkgs.curl
    pkgs.fasd
    pkgs.fortune
    pkgs.htop
    pkgs.rlwrap
    pkgs.wget
    pkgs.heroku
    pkgs.p7zip
    pkgs.readline
    # pkgs.openssh
    pkgs.unzip
    # pkgs.blackbox pkgs.keybase pkgs.keybase-gui
    pkgs.vscode
    # pkgs.firefox
    # pkgs.ghc pkgs.cabal-install pkgs.stack
    pkgs.pandoc
  ];

  home.file = {
    ".tmux.conf".source = ./tmux.conf;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
