.PHONY: key-collector-default
key-collector-default: ssh.hosts

ifndef git-included
include git.mk
endif

.DELETE_ON_ERROR:

ssh.hosts:
	find . -mindepth 1 -maxdepth 1 -type d -name "*@*:*" -printf "%f\n" >$@
	test -s $@

