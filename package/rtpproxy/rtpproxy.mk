#############################################################
#
# rtpproxy
#
#############################################################

RTPPROXY_VERSION = 1.3-beta.1
RTPPROXY_SITE = http://files.astlinux.org
RTPPROXY_SOURCE = rtpproxy-$(RTPPROXY_VERSION).tar.gz

$(eval $(call AUTOTARGETS,package,rtpproxy))
