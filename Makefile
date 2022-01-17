BITBAKE_SRC_DIR ?= bitbake
# The cut expression assumes three dash-delimited fields, wont work if tags contains dash
BITBAKE_VERSION := $(shell git -C bitbake describe --long | cut --delim=- --fields=3 --complement)
PKG_DIR = bitbake-manual-master-$(BITBAKE_VERSION)

all: bitbake-manual-master-pkg.el
	git -C bitbake describe --long
	mkdir -p $(PKG_DIR)
	cp bitbake/doc/_build/texinfo/bitbake.info $(PKG_DIR)/bitbake-master.info
	install-info --info-dir $(PKG_DIR) --info-file $(PKG_DIR)/bitbake-master.info
	cp bitbake-manual-master-pkg.el $(PKG_DIR)
	tar cf $(PKG_DIR).tar $(PKG_DIR)

bitbake-manual-master-pkg.el: bitbake-manual-master-pkg.el.in
	sed "s/@VERSION@/$(BITBAKE_VERSION)/g" $< > $@
