{ config, pkgs, ... }:

{
  # git with initial configration:wq
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
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
      amend = "!git add . && git commit --amend --no-edit";
      p = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      c = "!git add -A && git commit";
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
}
