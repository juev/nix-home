{ config, pkgs, ... }:

let 
  shellAliases = {
    h="history";
    l="ls -F1";
    la="ls -laF";
    ll="ls -lF --git";
    lsd="ls -FD";
    ls="command exa -F --group-directories-first --color=auto";
    df="df -Ph";
    ga="git-annex";
    du="du -Ph";
    wipe="srm -vfr";
    sudo="sudo ";
    week="date +%V";
    md5sum="md5";
    sha1sum="shasum";
    web="python -m http.server 8000";
    map="xargs -n1";
    cp="cp -i";
    mv="mv -i";
    p="pushd";
    o="popd";
    empty="find ~/Projects/ -type d -name \"target\" -exec rm -rf {} +";
    hadd="hledger add -f $HOME/Projects/Github/hledger/2021.journal";
    infra="ansible-playbook --vault-password-file ~/.vault_pass ";
    git-purge="git for-each-ref --format '%(refname:short)' refs/heads | grep -v master | xargs git branch -D";
    switch="nix-channel --update nixpkgs && home-manager switch";
  };
in {
  programs.bash = {
    inherit shellAliases;
    enable = true;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi

      source ${pkgs.bash-completion}/share/bash-completion/bash_completion
      source ~/.nix-profile/share/git/contrib/completion/git-completion.bash

      function g() {
        if [ -z "$1" ]; then
          git status
        else
          git "$@"
        fi
      }

      function take() {
        mkdir -p -- "$1" && cd -P -- "$1"
      }
      [[ -f $HOME/.env ]] && source $HOME/.env
    '';
  };
    # zsh settings
  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    history = {
      extended = true;
      path = ".config/zsh/history";
    };

    # Called whenever zsh is initialized
    initExtra = ''
      export TERM="xterm-256color"
      # Nix setup (environment variables, etc.)
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
      function take() {
        mkdir -p -- "$1" && cd -P -- "$1"
      }
      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys to Git
      [[ -e $HOME/.env ]] && source $HOME/.env
      # case-insensitive,partial-word and then substring completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    '';
  };
}
