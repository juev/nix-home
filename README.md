# Installation

`Note: I'm use Darwin.`

## Install Nix

```shell
$ sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```

## Install home-manager

```shell
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

Add this to your shell:

```shell
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
```

Install home-manager:

```shell
$ nix-shell '<home-manager>' -A install
```

Then add this to your shell:

```shell
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
```

## Use configuration

```shell
$ ln -s `pwd` ~/.config/nixpkgs
# skip it $ nix-env -f '<nixpkgs>' -iA home-manager
$ home-manager switch
```

## Some note

After clone repository use command:

```shell
git update-index --skip-worktree profile/private.nix
```

for ignoring changes on private configuration. And dont forget to change email address on this file :smile:

### Reference

1. [nix-community/home-manager](https://github.com/nix-community/home-manager)
1. [ihsanturk/dotfiles](https://github.com/ihsanturk/dotfiles)

