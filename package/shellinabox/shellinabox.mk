#############################################################
#
# shellinabox
#
#############################################################
SHELLINABOX_VERSION = 239
SHELLINABOX_SOURCE = shellinabox-$(SHELLINABOX_VERSION).tar.gz
#SHELLINABOX_SITE = http://shellinabox.googlecode.com/files
SHELLINABOX_SITE = http://files.astlinux.org
SHELLINABOX_DEPENDENCIES = openssl

define SHELLINABOX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/shellinaboxd $(TARGET_DIR)/usr/bin/shellinaboxd
	$(INSTALL) -D -m 0755 package/shellinabox/shellinaboxd.init $(TARGET_DIR)/etc/init.d/shellinaboxd
endef

define SHELLINABOX_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/shellinaboxd
	rm -f $(TARGET_DIR)/etc/init.d/shellinaboxd
endef

$(eval $(call AUTOTARGETS,package,shellinabox))
