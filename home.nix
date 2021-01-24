{ config, pkgs, ... }:

# https://nix-community.github.io/home-manager/options.html
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "d.evsyukov";
  home.homeDirectory = "/Users/d.evsyukov";

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
    pkgs.vscode
    pkgs.wget
  ];

  manual.manpages.enable = true;

  home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin/" "$HOME/go/bin"];
  home.sessionVariables = {
    ALTERNATE_EDITOR="";
    EDITOR="vim";
    LANG="en_US.UTF-8";
    LC_ALL="en_US.UTF-8";
    GREP_OPTIONS="--color=auto";
    WEBSITE="$HOME/Projects/juev.org";
    LEDGER_FILE="$HOME/Projects/Github/hledger/main.journal";
  };

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
    aliases = {
      l = "log --pretty=oneline -n 10";
      d = "diff";
      s = "status --short --branch --ignore-submodules=untracked";
      amend = "!git add . && git commit --amend --no-edit";
      p = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      c = "!git add -A && git commit -m ";
      cc = "!git commit --amend -m ";
      co = "checkout";
      f = "!git fetch --all && git rebase origin/master";
      undo = "reset HEAD~";
      prune = "!git co master && git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d";
      delete = "branch -D";
      sync = "!git pull -q -r origin master";
      m = "!git checkout master && git pull";
      last = "log -1 HEAD";
      pr = "pull --rebase";
      br = "branch";
      a = "add .";
      rh = "reset --hard";
      fixlast = "commit --all --amend --no-edit";
    };
    extraConfig = {
      core = { 
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space"; 
        trustctime = false;
        editor = "vim";
        autocrlf = "input";
        precomposeunicode = false;
        quotepath = false;
      };
      apply = {whitespace = "fix";};
      color = {ui = "auto";};
      diff = {renames = "copies";};
      help = {autocorrect = 1;};
      merge = {
        	log = true;
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
      push = {default = "simple";};
      github = {user = "juev";};
      pull = {rebase = "merges";};
    };
  };

  # enable autojump https://github.com/wting/autojump
  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
  };

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
      hadd="hledger add -f ~/Projects/Github/hledger/2021.journal";
    };
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

  home.file = {
    ".tmux.conf".source = ./config/tmux.conf;
    ".dir_colors".source = ./config/dircolors;
    ".inputrc".source = ./config/inputrc;
    ".gemrc".source = ./config/gemrc;
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
