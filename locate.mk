.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0 .locate_cp

locate: $(addsuffix .locate_head_1,$(ALL)) \
	$(addsuffix .locate_head_2,$(ALL)) \
	$(addsuffix .locate_head_3,$(ALL)) \
	$(addsuffix .locate_cp,$(ALL)) \
	locate_cp

%.locate:
	-locate $* >$@

%.locate_0 : %.locate_pruned
	tr '\n\r' '\0\0' <$< >$@

%.locate_pruned: %.locate
	$(call prune)

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

clean::
	-rm *.locate_0
	-rm *.locate_cp
	-rm *.locate_md5
