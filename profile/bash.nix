{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi

      function g() {
        if [ -z "$1" ]; then
          git status
        else
          git "$@"
        fi
      }
    '';
    shellAliases = {
      ".."="cd ..";
      "..."="cd ../..";
      "...."="cd ../../..";
      "....."="cd ../../../..";
      "~"="cd ~"; # `cd` is probably faster to type though
      "-- -"="cd -";
      h="history";
      e="emacsclient -n -a \"open /Applications/Emacs.app\"";
      cat="bat -p";
      l="ls -lF --color=auto";
      la="ls -laF --color=auto";
      ll="ls -lF --color=auto";
      lsd="ls -FD --color=auto";
      ls="command exa -F --color=auto";
      df="df -Ph";
      du="du -Ph";
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
      gp="git p";
      gc="git c";
      gco="git co";
      gm="git m";
      gs="git s";
      gu="git pull";
      gd="git d";
      gpf="git p -f";
      grh="git reset --hard";
      gprune="git branch -vv | grep ': gone]'|  grep -v '*' | awk '{ print $1; }' | xargs -r git branch -d";
      empty="find ~/Projects/ -type d -name \"target\" -exec rm -rf {} +";
      hadd="hledger add -f $HOME/Projects/Github/hledger/2021.journal";
      infra="ansible-playbook --vault-password-file ~/.vault_pass ";
    };
  };
}
