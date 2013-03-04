#############################################################
#
# libtool
#
#############################################################
LIBTOOL_VERSION = 2.2.10
LIBTOOL_SOURCE = libtool-$(LIBTOOL_VERSION).tar.gz
LIBTOOL_SITE = $(BR2_GNU_MIRROR)/libtool
LIBTOOL_INSTALL_STAGING = YES

HOST_LIBTOOL_LIBTOOL_PATCH = NO

define LIBTOOL_INSTALL_TARGET_CMDS
	cp -a $(STAGING_DIR)/usr/lib/libltdl.*so* $(TARGET_DIR)/usr/lib/
endef

define LIBTOOL_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/lib/libltdl.*so*
endef

$(eval $(call AUTOTARGETS,package,libtool))
$(eval $(call AUTOTARGETS,package,libtool,host))

# variables used by other packages
LIBTOOL = $(HOST_DIR)/usr/bin/libtool
LIBTOOLIZE = $(HOST_DIR)/usr/bin/libtoolize
