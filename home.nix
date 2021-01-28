{ config, pkgs, lib, ... }:

# https://nix-community.github.io/home-manager/options.html
let
  optionals = lib.optionals;
  os = builtins.currentSystem;
  isLinux = os == "x86_64-linux";
  isDarwin = os == "x86_64-darwin";
  userName = builtins.getEnv "USER";
  homeDirectory = builtins.getEnv "HOME";
in rec {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = userName;
  home.homeDirectory = homeDirectory;
  # home.homeDirectory = if isDarwin then
  #   /. + ("/Users/" + config.home.username)
  # else /. + ("/home/" + config.home.username);

  home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin/" "$HOME/go/bin"];
  home.sessionVariables = {
    ALTERNATE_EDITOR="";
    EDITOR="vim";
    LANG="en_US.UTF-8";
    GREP_OPTIONS="--color=auto";
    WEBSITE="$HOME/Projects/juev.org";
    LEDGER_FILE="$HOME/Projects/Github/hledger/main.journal";
    GPG_TTY="$(tty)";
  };

  home.file = {
    ".tmux.conf".source = ./config/tmux.conf;
    ".dir_colors".source = ./config/dircolors;
    ".inputrc".source = ./config/inputrc;
    ".gemrc".source = ./config/gemrc;
    ".gitmessage".source = ./config/gitmessage;
  };

  nixpkgs.overlays = [
    (import ./overlay)
  ];

  nixpkgs.config.trustedUsers = [
    config.home.username
    (optionals isLinux [ "root" ])
  ];

  imports = [
    ./profile/base.nix
    ./profile/bash.nix
    ./profile/git.nix
    ./profile/private.nix
  ]
  ++ (optionals isLinux [ ./profile/linux.nix ])
  ++ (optionals isDarwin [ ./profile/darwin.nix ]);

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
