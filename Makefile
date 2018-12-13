.PHONY: help allinone clean all bin everything bin-trash
.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0 .locate_cp\
	.everything .everything_path .everything_path_pruned .everything_curl
EVERYTHING=127.0.0.1:80
ALL=rsa pem key dsa private priv public pub gpg pgp crt cert

help:
	@echo no help

locate: $(addsuffix .locate_head_1,$(ALL)) \
	$(addsuffix .locate_head_2,$(ALL)) \
	$(addsuffix .locate_head_3,$(ALL)) \
	$(addsuffix .locate_cp,$(ALL)) \
	locate_cp

everything: everything_curl

clean:
	rm -f *.locate *.locate_pruned *.locate_head_?
	rm -rf everything_curl locate_cp

%.locate:
	locate $* >$@

%.everything:
	echo $*
	curl 'http://${EVERYTHING}/?j=1&path_column=1&q=$*' >$@

%.everything_path: %.everything
	cat $< | jq --raw-output ".results | .[] |(.path+\"\\\\\"+.name)" >$@
	#sed -n -r 's/^[\t ]+\"path\":\"(.+)\"[\r\n]+$$/\1/p' $< | sort | uniq >$@

%.everything_path_pruned: %.everything_path
	$(call prune)

%.everything_curl: %.everything_path_pruned
	sed -n -r 's/^(.+)$$/curl "http:\/\/${EVERYTHING}\/\1" -g -s -S -R -o `mktemp -p . -u`.bin/p' $< >$@

everything_curl: allinone.everything_curl
	-mkdir $@
	(cd $@; sh -x ../$<)

allinone.everything_curl: $(addsuffix .everything_curl,$(ALL)) 
	cat  $^ | sort | uniq >$@

%.locate_0 : %.locate_pruned
	tr '\n\r' '\0\0' <$< >$@

%.locate_pruned: %.locate
	$(call prune)

define prune
	cat $< | sed -n -r\
		-e '/Anaconda.+qt$$/d' \
		-e '/AndroidStudio.+keystream$$/d' \
		-e '/AndroidStudio.+namespacekey$$/d' \
		-e '/AndroidStudio.+storage$$/d' \
		-e '/Program Files/d' \
		-e '/SoftwareDistribution.+Download/d' \
		-e '/SysWOW64/d' \
		-e '/System32/d' \
		-e '/Tableau.+Caching/d' \
		-e '/VSCode.+keymap/d' \
		-e '/WINDOWS.+NewOS/d' \
		-e '/WINDOWS.~BT/d' \
		-e '/WinSxS/d' \
		-e '/Windows.+Installer/d' \
		-e '/\.c$$/d' \
		-e '/\.code$$/d' \
		-e '/\.cpp$$/d' \
		-e '/\.css$$/d' \
		-e '/\.dart$$/d' \
		-e '/\.dll$$/d' \
		-e '/\.exe$$/d' \
		-e '/\.flat$$/d' \
		-e '/\.gif$$/d' \
		-e '/\.git.+objects/d' \
		-e '/\.h$$/d' \
		-e '/\.hpp$$/d' \
		-e '/\.html$$/d' \
		-e '/\.img$$/d' \
		-e '/\.inf$$/d' \
		-e '/\.jar$$/d' \
		-e '/\.java$$/d' \
		-e '/\.jpeg$$/d' \
		-e '/\.jpg$$/d' \
		-e '/\.js$$/d' \
		-e '/\.len$$/d' \
		-e '/\.man$$/d' \
		-e '/\.msi$$/d' \
		-e '/\.nse$$/d' \
		-e '/\.obj$$/d' \
		-e '/\.php$$/d' \
		-e '/\.png$$/d' \
		-e '/\.py$$/d' \
		-e '/\.pyc$$/d' \
		-e '/\.qcow2$$/d' \
		-e '/\.sample$$/d' \
		-e '/\.settingcontent-ms$$/d' \
		-e '/\.svg$$/d' \
		-e '/\.svn.+prop-base/d' \
		-e '/\.svn.+text-base/d' \
		-e '/\.tmpl$$/d' \
		-e '/\.vbs$$/d' \
		-e '/\.xml$$/d' \
		-e '/__pycache__/d' \
		-e '/android-[0-9]+/d' \
		-e '/android.+m2repository/d' \
		-e '/bin.+gpg/d' \
		-e '/bin.+key/d' \
		-e '/dart-tool/d' \
		-e '/doc.keyboard/d' \
		-e '/flutter_tools/d' \
		-e '/gradle.+m2repository/d' \
		-e '/gradle.+wrapper/d' \
		-e '/keybinding/d' \
		-e '/keycode/d' \
		-e '/naver.+line.+sticker/d' \
		-e '/org.+eclipse/d' \
		-e '/perl.+pm$$/d' \
		-e '/pub-cache/d' \
		-e '/softwaredistribution.+Download/d' \
		-e '/terminfo.+keys$$/d' \
		-e '/tzdata/d' \
		-e '/usr.+share.+doc/d' \
		-e '/vim8.+keymap/d' \
		-e '/xkb.+keycodes/d' \
		-e p >$@
	wc $@
endef

%.locate_head_1 : %.locate_0
	-(cat $< | xargs -n 1 -0 head -v -n 1 ) >$@
	wc $@

%.locate_head_2 : %.locate_0
	-(cat $< | xargs -n 1 -0 head -v -n 2 ) >$@
	wc $@

%.locate_head_3 : %.locate_0
	-(cat $< | xargs -n 1 -0 head -v -n 3 ) >$@
	wc $@

allinone.locate_0: $(addsuffix .locate_0,$(ALL))
	cat $^  | sort | uniq >$@

%.locate_md5: %.locate_0
	cat $< | xargs -0 md5sum >$@

%.locate_cp: %.locate_md5
	sed -n -r -e 's/^([0-9a-fA-F]{32})  (.+)$$/cp "\2" \1.bin/p' <$< >$@

locate_cp: allinone.locate_cp
	mkdir $@
	(cd $@; sh -x ../$<)

everything_curl.md5: everything_curl
	find $</ -mindepth 1 -type f -name "tmp.*" -print0 | xargs -0 md5sum >$@

everything_curl.mv: everything_curl.md5
	sed -n -r 's/^([0-9a-fA-F]{32})  (.+)$$/mv "\2" everything_curl\/\1.bin/p' $< >$@

bin:
	-mkdir $@
	mv everything_curl/*.bin $@
	mv locate_cp/*.bin $@

bin.file:
	file bin/* >$@

bin-trash: bin.file
	-rm $@
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
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM RSA private key$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-pem-rsa-public-key: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM RSA public key$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-pem-dsa-private-key: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM DSA private key$$/\1/p' $<  	| xargs -I {} mv {} $@/

bin-pem-dsa-public-key: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM DSA public key$$/\1/p' $<  	| xargs -I {} mv {} $@/

bin-zip: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): Zip archive data.*$$/\1/p' $< 	| xargs -I {} mv {} $@/

bin-gzip: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): gzip compressed data.*$$/\1/p' $<	| xargs -I {} mv {} $@/

bin-bzip2: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): bzip2 compressed data.*$$/\1/p' $< | xargs -I {} mv {} $@/

bin-ascii-text: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): ASCII text.*$$/\1/p' $< 		| xargs -I {} mv {} $@/

bin-xml: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): XML.*$$/\1/p' $<			| xargs -I {} mv {} $@/

bin-gpg-key-public-ring: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): GPG key public ring.*$$/\1/p' $<	| xargs -I {} mv {} $@/

bin-data: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): data$$/\1/p' $<			| xargs -I {} mv {} $@/

bin-pem-certificate-request: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): PEM certificate request$$/\1/p' $<| xargs -I {} mv {} $@/

bin-unicode-text: bin.file
	-rm -rf $@; mkdir $@
	sed -n -r 's/^(bin.[0-9a-fA-F]+.bin): UTF-8 Unicode.+text.*$$/\1/p' $<| xargs -I {} mv {} $@/

