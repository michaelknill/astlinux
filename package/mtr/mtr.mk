#############################################################
#
# mtr
#
#############################################################
MTR_VERSION = 0.82
MTR_SITE = ftp://ftp.bitwizard.nl/mtr
MTR_SOURCE = mtr-$(MTR_VERSION).tar.gz

MTR_DEPENDENCIES = ncurses

MTR_CONF_OPT = \
        --without-gtk

define MTR_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mtr $(TARGET_DIR)/usr/bin/
endef

define MTR_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/mtr
endef

$(eval $(call AUTOTARGETS,package,mtr))
