{ config, pkgs, ... }:

{
  # git with initial configration:wq
  programs.git = {
    enable = true;
    userName = "Denis Evsyukov";
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
      amend = "commit --amend  -C HEAD";
      p = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      push = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      c = "commit -v";
      ac = "commit -va";
      ca = "commit --amend";
      co = "checkout";
      cp = "cherry-pick";
      undo = "reset HEAD~";
      prune = "!git co master && git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d";
      delete = "branch -D";
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
        whitespace = "trailing-space,space-before-tab";
        trustctime = false;
        editor = "vim";
        autocrlf = "input";
        precomposeunicode = false;
        quotepath = false;
      };
      merge = {
        log = true;
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      diff = {
        ignoreSubmodules = "dirty";
        renames = "copies";
        mnemonicprefix = true;
      };
      color = {
        status      = "auto";
        diff        = "auto";
        branch      = "auto";
        interactive = "auto";
        ui          = "auto";
        sh          = "auto";
      };
      init.defaultBranch = "main";
      apply.whitespace = "fix";
      branch.autosetupmerge = true;
      commit.template = "~/.gitmessage";
      github.user = "juev";
      help.autocorrect = 1;
      mergetool.keepBackup  = true;
      pull.rebase           = true;
      push.default = "tracking";
      rebase.autosquash     = true;
    };
  };
}
