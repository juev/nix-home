{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi

      source ${pkgs.bash-completion}/share/bash-completion/bash_completion

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
    '';
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
    };
  };
}
