.PHONY: help allinone clean all bin everything bin-trash everything_curl
.SUFFIXES: .locate .locate_pruned .locate_head_1 .locate_head_2 .locate_head_3 .locate_0 .locate_cp\
	.everything .everything_path .everything_path_pruned .everything_curl
.PRECIOUS: %.everything_path_pruned
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
	-locate $* >$@

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

everything_curl: $(addsuffix .everything_curl,$(ALL))
	#echo $^ | xargs -n1 -I {} '(mkdir {}; cd {}; sh -x ../{})'
	echo $^ | xargs -d\  -t -n1 -I {} sh -c 'mkdir $@; cd $@; sh -x ../{}'

%.locate_0 : %.locate_pruned
	tr '\n\r' '\0\0' <$< >$@

%.locate_pruned: %.locate
	$(call prune)

define prune
	cat $< | sed -n -r\
		-e '/Anaconda.+qt/d' \
		-e '/Anaconda.+site-packages/d' \
		-e '/AndroidStudio.+keystream/d' \
		-e '/AndroidStudio.+namespacekey/d' \
		-e '/AndroidStudio.+storage/d' \
		-e '/AppIconCache/d' \
		-e '/Microsoft.+NetFramework/d' \
		-e '/catalog_image/d' \
		-e '/Program Files/d' \
		-e '/SoftwareDistribution.+Download/d' \
		-e '/SysWOW64/d' \
		-e '/System32/d' \
		-e '/Tableau.+Caching/d' \
		-e '/VSCode.+keymap/d' \
		-e '/Warsaw$$/d' \
		-e '/WINDOWS.+NewOS/d' \
		-e '/WINDOWS.~BT/d' \
		-e '/WinSxS/d' \
		-e '/share.+terminfo/d' \
		-e '/Windows.+AppRepository/d' \
		-e '/Windows.+Installer/d' \
		-e '/LibreOffice.+extensions/d' \
		-e '/share.+zoneinfo/d' \
		-e '/\.azw..$$/d' \
		-e '/\.c$$/d' \
		-e '/\.code$$/d' \
		-e '/\.lua$$/d' \
		-e '/\.cpp$$/d' \
		-e '/\.css$$/d' \
		-e '/\.csv$$/d' \
		-e '/\.dart$$/d' \
		-e '/\.deb$$/d' \
		-e '/\.dll$$/d' \
		-e '/\.egg-info$$/d' \
		-e '/\.exe$$/d' \
		-e '/\.flat$$/d' \
		-e '/\.gif$$/d' \
		-e '/\.git.+objects/d' \
		-e '/\.gyp$$/d' \
		-e '/\.h$$/d' \
		-e '/\.hpp$$/d' \
		-e '/\.htm$$/d' \
		-e '/\.html$$/d' \
		-e '/\.idb$$/d' \
		-e '/\.img$$/d' \
		-e '/\.inf$$/d' \
		-e '/\.jar$$/d' \
		-e '/\.java$$/d' \
		-e '/\.jpeg$$/d' \
		-e '/\.jpg$$/d' \
		-e '/\.js$$/d' \
		-e '/\.keymaps$$/d' \
		-e '/\.len$$/d' \
		-e '/\.lnk$$/d' \
		-e '/\.lzh$$/d' \
		-e '/\.man$$/d' \
		-e '/\.mkv$$/d' \
		-e '/\.mp3$$/d' \
		-e '/\.mp33$$/d' \
		-e '/\.msi$$/d' \
		-e '/\.nse$$/d' \
		-e '/\.obj$$/d' \
		-e '/\.php$$/d' \
		-e '/\.png$$/d' \
		-e '/\.pod$$/d' \
		-e '/\.properties$$/d' \
		-e '/\.py$$/d' \
		-e '/\.pyc$$/d' \
		-e '/\.qcow2$$/d' \
		-e '/\.res$$/d' \
		-e '/\.rst$$/d' \
		-e '/\.sample$$/d' \
		-e '/\.sdr$$/d' \
		-e '/\.settingcontent-ms$$/d' \
		-e '/\.sh$$/d' \
		-e '/\.sln$$/d' \
		-e '/\.svg$$/d' \
		-e '/\.svn.+prop-base/d' \
		-e '/\.svn.+text-base/d' \
		-e '/\.tmpl$$/d' \
		-e '/\.translation$$/d' \
		-e '/\.vbs$$/d' \
		-e '/\.vcproj$$/d' \
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
		-e '/node_modules/d' \
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

include bin.mk
