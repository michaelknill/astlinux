#############################################################
#
# sipgrep
#
#############################################################

SIPGREP_VERSION = 2.0.0
SIPGREP_SOURCE = sipgrep-$(SIPGREP_VERSION).tar.gz
SIPGREP_SITE = http://files.astlinux.org
#SIPGREP_SITE = https://github.com/adubovikov/sipgrep/releases
SIPGREP_DEPENDENCIES = libpcap pcre

SIPGREP_UNINSTALL_STAGING_OPT = --version

SIPGREP_CONF_OPT += \
	--with-pcap-includes=$(STAGING_DIR)/usr/include \
	--enable-ipv6

define SIPGREP_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/sipgrep $(TARGET_DIR)/usr/bin/sipgrep
endef

define SIPGREP_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/sipgrep
endef

$(eval $(call AUTOTARGETS,package,sipgrep))
