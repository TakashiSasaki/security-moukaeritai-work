.PHONY: pem convert-private-key-in-pem
.ONESHELL:

pem:  id_rsa.public.pem convert-private-key-in-pem

convert-private-key-in-pem: id_rsa.public.pem 
	ssh-keygen -p -f id_rsa -m PEM 

id_rsa.public.pem: id_rsa
	ssh-keygen -e -m PEM -f $< > $@

