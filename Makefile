default: help

NIXOSARGS?=
HOMEARGS?=

define HELP_BODY
This Makefile provided several tasks:
  1. all -- used for installing nix, home-manager and activate current configuration
  2. install-nix -- used for installing nix
  3. install-hm -- used for installing home-manager
  4. home-manager -- used for activating current configuration
  5. uninstall -- used for removing home-manager configuration
endef

export HELP_BODY

.PHONY: help
help :
	@echo "$$HELP_BODY"

.PHONY: all
all : install-nix install-hm home-manager

.PHONY: install-nix
install-nix :
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		sh <(curl -L https://nixos.org/nix/install) --daemon
	endif
	ifeq ($(UNAME_S),Darwin)
		sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
	endif

.PHONY: install-hm
install-hm :
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

.PHONY: home-manager
home-manager :
	ln -is ${PWD} ${HOME}/.config/nixpkgs
	home-manager switch ${HOMEARGS}

.PHONY: uninstall
uninstall :
	sudo rm -rf ${HOME}/.config/nixpkgs
