#############################################################
#
# asterisk-codec-silk
#
##############################################################
ifeq ($(BR2_PACKAGE_ASTERISK_v11),y)
ASTERISK_CODEC_SILK_VERSION := 11.0_1.0.0-i686_32
ASTERISK_CODEC_SILK_SITE := http://downloads.digium.com/pub/telephony/codec_silk/asterisk-11.0/x86-32
endif
ASTERISK_CODEC_SILK_SOURCE := codec_silk-$(ASTERISK_CODEC_SILK_VERSION).tar.gz
ASTERISK_CODEC_SILK_DIR := $(BUILD_DIR)/codec_silk-$(ASTERISK_CODEC_SILK_VERSION)
ASTERISK_CODEC_SILK_BINARY := usr/lib/asterisk/modules/codec_silk.so

$(DL_DIR)/$(ASTERISK_CODEC_SILK_SOURCE):
ifeq ($(ASTERISK_CODEC_SILK_VERSION),)
	@echo "Asterisk SILK CODEC not supported with the selected version of Asterisk"
	@exit 1
endif
	$(WGET) -P $(DL_DIR) $(ASTERISK_CODEC_SILK_SITE)/$(ASTERISK_CODEC_SILK_SOURCE)

$(ASTERISK_CODEC_SILK_DIR)/.source: $(DL_DIR)/$(ASTERISK_CODEC_SILK_SOURCE)
	zcat $(DL_DIR)/$(ASTERISK_CODEC_SILK_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	touch $@

$(TARGET_DIR)/$(ASTERISK_CODEC_SILK_BINARY): $(ASTERISK_CODEC_SILK_DIR)/.source | asterisk
	$(INSTALL) -D -m 0755 $(ASTERISK_CODEC_SILK_DIR)/codec_silk.so $(TARGET_DIR)/$(ASTERISK_CODEC_SILK_BINARY)

asterisk-codec-silk: $(TARGET_DIR)/$(ASTERISK_CODEC_SILK_BINARY)

asterisk-codec-silk-clean:
	rm -f $(TARGET_DIR)/$(ASTERISK_CODEC_SILK_BINARY)

asterisk-codec-silk-dirclean:
	rm -rf $(ASTERISK_CODEC_SILK_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_ASTERISK_CODEC_SILK)),y)
TARGETS+=asterisk-codec-silk
endif
