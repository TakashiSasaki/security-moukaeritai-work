.PHONY: help allinone clean all bin 
ALL=rsa pem key dsa private priv public pub gpg pgp crt cert

help:
	@echo no help


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
		-e '/\.azw3$$/d' \
		-e '/\.c$$/d' \
		-e '/\.code$$/d' \
		-e '/\.ini$$/d' \
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
		-e '/\.md5$$/d' \
		-e '/\.md5sums$$/d' \
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
		-e '/\.ui$$/d' \
		-e '/\.dsp$$/d' \
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

include locate.mk
include everything.mk
include bin.mk
