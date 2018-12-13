.PHONY: help
.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0
ALL=rsa pem key dsa private priv public pub

all: $(addsuffix .locate_head_1,$(ALL)) \
	$(addsuffix .locate_head_2,$(ALL)) \
	$(addsuffix .locate_head_3,$(ALL))

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
		-e '/WinSxS/d' \
		-e '/SysWOW64/d' \
		-e '/org.eclipse/d' \
		-e '/android-[0-9]+/d' \
		-e '/Program Files/d' \
		-e '/pub-cache/d' \
		-e '/gradle.caches/d' \
		-e '/gradle.wrapper/d' \
		-e '/xkb.keycodes/d' \
		-e '/vim80.keymap/d' \
		-e '/.py$$/d' \
		-e '/.js$$/d' \
		-e '/.exe$$/d' \
		-e '/.pyc$$/d' \
		-e '/.len$$/d' \
		-e '/.img$$/d' \
		-e '/.flat$$/d' \
		-e '/.png$$/d' \
		-e '/.java$$/d' \
		-e '/.jar$$/d' \
		-e '/.tmpl$$/d' \
		-e '/.sample$$/d' \
		-e '/System32/d' \
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
