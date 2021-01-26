{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.age
    pkgs.aria2
    pkgs.bash-completion
    pkgs.bashInteractive_5
    pkgs.bat
    pkgs.coreutils
    pkgs.curl
    pkgs.diffutils        # For `cmp` and `diff`.
    pkgs.emacs
    pkgs.exa
    pkgs.fd
    pkgs.findutils
    pkgs.fortune
    pkgs.gettext
    pkgs.gnugrep
    pkgs.gnupg
    pkgs.gnused
    pkgs.go
    pkgs.heroku
    pkgs.hexyl
    pkgs.hledger
    pkgs.htop
    pkgs.hugo
    pkgs.jq
    pkgs.kubectl
    pkgs.mc
    pkgs.mosh
    pkgs.ncurses
    pkgs.p7zip
    pkgs.pandoc
    pkgs.readline
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.rlwrap
    pkgs.rustup
    pkgs.terraform
    pkgs.tldr
    pkgs.tree
    pkgs.unzip
    pkgs.upx
    pkgs.vim
    pkgs.wget
  ];

  manual.manpages.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
    # aggressiveResize = true;
    # baseIndex = 1;
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableBashIntegration = true;
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  # enable autojump https://github.com/wting/autojump
  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
  };

  # https://starship.rs/config/#configuration
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
      hostname = {
        ssh_only = true;
        format =  "on [$hostname](bold red) ";
        trim_at = ".companyname.com";
        disabled = false;
      };
    };
  };

  programs.lesspipe.enable = true;
  programs.man.enable = true;

  programs.readline = {
    enable = true;
    bindings = {
      "\\e[B" = "history-search-forward";
      "\\e[A" = "history-search-backward";
      "\\e[3;3~" = "kill-word";
      "\\e[1;5D" = "backward-word";
      "\\e[1;5C" = "forward-word";
    };
    extraConfig = ''
      set bell-style none
      set keymap emacs
      set completion-ignore-case on
      set show-all-if-ambiguous on
      set mark-symlinked-directories on
      set match-hidden-files off
      set page-completions off
      set completion-query-items 200
      set visible-stats on
      set skip-completed-text on
      set input-meta on
      set output-meta on
      set convert-meta off
      set show-all-if-unmodified on
    '';
    includeSystemConfig = true;
  };
}
