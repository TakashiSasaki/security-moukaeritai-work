.PHONY: clean everything_curl everything_curl.md5 everything_curl.mv
.PRECIOUS: %.everything_path_pruned
.SUFFIXES: .everything .everything_path .everything_path_pruned .everything_curl .everything_bin
EVERYTHING=127.0.0.1:80


everything: everything_curl


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

%.everything_bin: %.everything_curl
	-mkdir $@
	(cd $@; sh -x ../$<)

everything_curl: $(addsuffix .everything_curl,$(ALL))
	#echo $^ | xargs -n1 -I {} '(mkdir {}; cd {}; sh -x ../{})'
	echo $^ | xargs -d\  -t -n1 -I {} sh -c 'mkdir $@; cd $@; sh -x ../{}'

everything_curl.md5: everything_curl
	find $</ -mindepth 1 -type f -name "tmp.*" -print0 | xargs -0 md5sum >$@

everything_curl.mv: everything_curl.md5
	sed -n -r 's/^([0-9a-fA-F]{32})  (.+)$$/mv "\2" everything_curl\/\1.bin/p' $< >$@


clean::
	-rm *.everything_curl	
	-rm *.everything_path_pruned
