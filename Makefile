.PHONY: help allinone clean all
.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0
ALL=rsa pem key dsa private priv public pub gpg pgp crt cert

all: $(addsuffix .locate_head_1,$(ALL)) \
	$(addsuffix .locate_head_2,$(ALL)) \
	$(addsuffix .locate_head_3,$(ALL)) \
	allinone.locate_0

help:
	@echo no help

clean:
	rm -f *.locate *.locate_pruned *.locate_head_?

%.locate:
	locate $* >$@

%.locate_0 : %.locate_pruned
	tr '\n\r' '\0\0' <$< >$@

%.locate_pruned: %.locate
	cat $< | sed -n -r\
		-e '/.dat64$$/d' \
		-e '/.dll$$/d' \
		-e '/.exe$$/d' \
		-e '/.flat$$/d' \
		-e '/.img$$/d' \
		-e '/.jar$$/d' \
		-e '/.java$$/d' \
		-e '/.js$$/d' \
		-e '/.len$$/d' \
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
		-e '/WinSxS/d' \
		-e '/\.git.objects/d' \
		-e '/\/bin\/.+key.?$$/d' \
		-e '/\/bin\/gpg/d' \
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
		-e '/pub-cache/d' \
		-e '/terminfo.+keys$$/d' \
		-e '/vim8..keymap/d' \
		-e '/xkb.keycodes/d' \
		-e p >$@
	wc $@

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
	cat $^ >$@

