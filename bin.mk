bin: locate_cp everything_curl
	-mkdir $@
	-mv everything_curl/*.bin $@
	-mv locate_cp/*.bin $@

bin.file:
	file bin/* >$@

bin-all: \
	bin-ascii-text \
	bin-bzip2 \
	bin-data \
	bin-gpg-key-public-ring \
	bin-gzip \
	bin-openssh-dsa-public-key \
	bin-openssh-rsa-public-key \
	bin-pem-certificate-request \
	bin-pem-dsa-private-key \
	bin-pem-dsa-public-key \
	bin-pem-rsa-private-key \
	bin-pem-rsa-public-key \
	bin-trash \
	bin-unicode-text \
	bin-xml \
	bin-zip \


bin-trash: bin.file
	-mkdir $@ 
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Algol .*$$/\1/p' $< 	  		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Audio .*$$/\1/p' $< 	  		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Berkeley DB.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*C source.*$$/\1/p' $< 	  		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*COFF .*$$/\1/p' $< 	  		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*C\+\+ source.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Composite Document.*$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Debian binary package.*$$/\1/p' $< 	| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*ELF.+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*HTML.+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*JPEG.+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Java .+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*MS Windows icon.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*MS Windows shortcut.*$$/\1/p' $< 	| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*MSVC.+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Macromedia Flash.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Microsoft Excel.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Microsoft PowerPoint.*$$/\1/p' $< 	| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Ogg.+Vorbis.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*PDF .+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*PE32 executable.*$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*PE32\+ .+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*POSIX shell script.+$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Perl POD.+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Perl script.+$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Perl5.+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Python script.+$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Rich Text Format.*$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Ruby script.+$$/\1/p' $<		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*SGML.*$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*SQLite.+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*TeX document.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*TrueType.+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*WebM.*$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*Windows Registry.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*ar archive.*$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*image.+$$/\1/p' $<			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*terminfo.+$$/\1/p' $< 			| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*timezone data.+$$/\1/p' $< 		| xargs -I {} mv {} $@/
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): .*troff.+$$/\1/p' $< 			| xargs -I {} mv {} $@/

bin-pem-rsa-private-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM RSA private key$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-pem-rsa-public-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM RSA public key$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-pem-dsa-private-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM DSA private key$$/\1/p' $<  	| xargs -I {} mv {} $@/

bin-pem-dsa-public-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM DSA public key$$/\1/p' $<  	| xargs -I {} mv {} $@/

bin-zip: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): Zip archive data.*$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-gzip: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): gzip compressed data.*$$/\1/p' $<	| xargs -I {} mv {} $@/

bin-bzip2: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): bzip2 compressed data.*$$/\1/p' $< | xargs -I {} mv {} $@/

bin-ascii-text: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): ASCII text.*$$/\1/p' $< 		| xargs -I {} mv {} $@/

bin-xml: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): XML.*$$/\1/p' $<			| xargs -I {} mv {} $@/

bin-gpg-key-public-ring: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): GPG key public ring.*$$/\1/p' $<	| xargs -I {} mv {} $@/

bin-data: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): data$$/\1/p' $<			| xargs -I {} mv {} $@/

bin-pem-certificate-request: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM certificate request$$/\1/p' $<| xargs -I {} mv {} $@/

bin-unicode-text: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): UTF-8 Unicode.+text.*$$/\1/p' $<| xargs -I {} mv {} $@/

bin-openssh-dsa-public-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): OpenSH DSA public key.*$$/\1/p' $<| xargs -I {} mv {} $@/

bin-openssh-rsa-public-key: bin.file
	-mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): OpenSH RSA public key.*$$/\1/p' $<| xargs -I {} mv {} $@/
