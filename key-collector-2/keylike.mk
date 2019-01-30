ifndef keylike-included
keylike-included=1
.DELETE_ON_ERROR:
.PHONY: keylike-default
keylike-default: home.keylike.md5s

ifndef clean-included
include clean.mk
endif

ifndef md5-included
include md5.mk
endif

ifndef updatedb-included
include updatedb.mk
endif

.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0
keylike_suffixes=rsa pem key dsa private priv public pub gpg pgp crt cert

%.keylike.files : %.locate02
	-rm $@
	$(eval temp1=$(shell mktemp))
	$(foreach x,$(keylike_suffixes),$(shell locate -d $< *.$(x) >> $(temp1)))
	cat $(temp1) | sed -n -r\
		-e '/.dart$$/d' \
		-e '/.dll$$/d' \
		-e '/.exe$$/d' \
		-e '/.flat$$/d' \
		-e '/.img$$/d' \
		-e '/.inf$$/d' \
		-e '/.jar$$/d' \
		-e '/.java$$/d' \
		-e '/.js$$/d' \
		-e '/.len$$/d' \
		-e '/.nse$$/d' \
		-e '/.png$$/d' \
		-e '/.py$$/d' \
		-e '/.pyc$$/d' \
		-e '/.qcow2$$/d' \
		-e '/.sample$$/d' \
		-e '/.tmpl$$/d' \
		-e '/AndroidStudio.+keystream$$/d' \
		-e '/AndroidStudio.+namespacekey$$/d' \
		-e '/AndroidStudio.+storage$$/d' \
		-e '/Program Files/d' \
		-e '/SysWOW64/d' \
		-e '/System32/d' \
		-e '/VSCode.+keymap/d' \
		-e '/WinSxS/d' \
		-e '/Windows.Installer/d' \
		-e '/\.git.objects/d' \
		-e '/\/bin\/.+key.?$$/d' \
		-e '/\/bin\/gpg/d' \
		-e '/\/tzdata/d' \
		-e '/\/usr\/share\/doc/d' \
		-e '/android-[0-9]+/d' \
		-e '/android.m2repository/d' \
		-e '/dart-tool/d' \
		-e '/doc.keyboard/d' \
		-e '/flutter_tools/d' \
		-e '/gradle.caches/d' \
		-e '/gradle.m2repository/d' \
		-e '/gradle.wrapper/d' \
		-e '/keybinding/d' \
		-e '/keycode/d' \
		-e '/org.eclipse/d' \
		-e '/perl.+pm$$/d' \
		-e '/pub-cache/d' \
		-e '/terminfo.+keys$$/d' \
		-e '/vim8..keymap/d' \
		-e '/xkb.keycodes/d' \
		-e p >$@

%.cp: %.md5
	sed -n -r -e 's/^([0-9a-fA-F]{32})  (.+)$$/cp "\2" \1.bin/p' <$< >$@

bin: allinone.cp
	mkdir bin	
	(cd bin; source ../$<)

endif # keylike-included

