default: home-manager

NIXOSARGS?=
HOMEARGS?=

home-manager:
	ln -is ${PWD} ${HOME}/.config/nixpkgs
	home-manager switch ${HOMEARGS}

uninstall:
	sudo rm -rf ${HOME}/.config/nixpkgs
