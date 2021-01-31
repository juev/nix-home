{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    age
    aria2
    bash-completion
    bashInteractive_5
    bat
    coreutils
    curl
    diffutils        # For `cmp` and `diff`.
    emacs
    exa
    fd
    findutils
    fortune
    gettext
    gnugrep
    gnupg
    gnused
    go
    heroku
    hexyl
    hledger
    htop
    hugo
    jq
    kubectl
    mc
    mosh
    ncurses
    p7zip
    pandoc
    readline
    ripgrep
    rlwrap
    rsync
    rustup
    srm
    terraform
    tldr
    tmux
    tree
    unzip
    upx
    vim
    wget
  ];

  manual.manpages.enable = true;

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (
      ext: with ext; [
        pass-audit
        pass-checkup
        pass-genphrase
        pass-otp
        pass-update
      ]
      );
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.secrets/password-store";
    };
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
      add_newline = true;
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
