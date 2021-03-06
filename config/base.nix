{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    age
    bash-completion
    bashInteractive_5
    bat
    cachix
    coreutils-full
    curl
    diffutils        # For `cmp` and `diff`.
    exa
    fd
    findutils
    fzf
    gettext
    gnugrep
    gnupg
    gnused
    go
    hledger
    htop
    hugo
    jq
    mosh
    ncurses
    nix-bash-completions
    p7zip
    pandoc
    readline
    ripgrep
    rlwrap
    rustup
    sd
    stack
    telnet
    terraform
    tmux
    tree
    unzip
    upx
    vim
    xh
    xz
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
  };

  programs.dircolors = {
    enable = true;
  };

  # enable autojump https://github.com/wting/autojump
  programs.autojump = {
    enable = true;
  };

  # https://starship.rs/config/#configuration
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      scan_timeout = 10;
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
  programs.neovim ={
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
    set runtimepath+=~/.vim,~/.vim/after
    set packpath+=~/.vim
    source ~/.vimrc
    '';
  };
}
