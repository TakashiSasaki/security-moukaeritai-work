.PHONY: pem convert-private-key-in-pem
.ONESHELL:

pem:  id_rsa.public.pem convert-private-key-in-pem

convert-private-key-in-pem: id_rsa.public.pem 
	ssh-keygen -p -f id_rsa -m PEM 

id_rsa.public.pem: id_rsa
	ssh-keygen -e -m PEM -f $< > $@

show-host-keys: 
	ssh-keygen -l -f /etc/ssh/ssh_host_ecdsa_key.pub  
	ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
	ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub
