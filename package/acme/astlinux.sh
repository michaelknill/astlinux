#!/usr/bin/env sh

# acme.sh deploy script for AstLinux
# This file name is "astlinux.sh"
# So, here must be a method astlinux_deploy()
# Which will be called by acme.sh to deploy the cert
# returns 0 means success, otherwise error.

. /etc/rc.conf

#service_type
astlinux_is_acme_service()
{
  local service IFS

  unset IFS
  for service in $ACME_SERVICE; do
    if [ "$service" = "$1" ]; then
      return 0
    fi
  done

  return 1
}

########  Public functions #####################

#domain keyfile certfile cafile fullchain
astlinux_deploy() {
  _cdomain="$1"
  _ckey="$2"
  _ccert="$3"
  _cca="$4"
  _cfullchain="$5"

  _debug _cdomain "$_cdomain"
  _debug _ckey "$_ckey"
  _debug _ccert "$_ccert"
  _debug _cca "$_cca"
  _debug _cfullchain "$_cfullchain"

  if astlinux_is_acme_service lighttpd; then
    if [ -z "$HTTPSCERT" ]; then
      logger -s -t acme-client "Failed to deploy ACME certificates HTTPS, invalid HTTPSCERT path"
    else
      service lighttpd stop
      cat "$_ckey" "$_ccert" > "$HTTPSCERT"
      chmod 600 "$HTTPSCERT"
      if [ -n "$HTTPSCHAIN" ]; then
        if [ -f "$_cfullchain" ]; then
          cat "$_cfullchain" > "$HTTPSCHAIN"
        else
          rm -f "$HTTPSCHAIN"
        fi
      fi
      sleep 1
      service lighttpd init
      logger -s -t acme-client "New ACME certificates deployed for HTTPS and Lighttpd restarted"
    fi
  fi

  if astlinux_is_acme_service asterisk; then
    mkdir -p /mnt/kd/ssl/sip-tls/keys
    if [ -f "$_cfullchain" ]; then
      cat "$_cfullchain" > /mnt/kd/ssl/sip-tls/keys/server.crt
    else
      cat "$_ccert" > /mnt/kd/ssl/sip-tls/keys/server.crt
    fi
    cat "$_ckey" > /mnt/kd/ssl/sip-tls/keys/server.key
    chmod 600 /mnt/kd/ssl/sip-tls/keys/server.key
    asterisk -rx "core restart when convenient" >/dev/null 2>&1 &
    logger -s -t acme-client "New ACME certificates deployed for SIP-TLS and Asterisk restart when convenient requested"
  fi

  if astlinux_is_acme_service prosody; then
    service prosody stop
    mkdir -p /mnt/kd/prosody/certs
    if [ -f "$_cfullchain" ]; then
      cat "$_cfullchain" > /mnt/kd/prosody/certs/server.crt
    else
      cat "$_ccert" > /mnt/kd/prosody/certs/server.crt
    fi
    cat "$_ckey" > /mnt/kd/prosody/certs/server.key
    chmod 600 /mnt/kd/prosody/certs/server.key
    chown prosody:prosody /mnt/kd/prosody/certs/server.crt
    chown prosody:prosody /mnt/kd/prosody/certs/server.key
    sleep 1
    service prosody init
    logger -s -t acme-client "New ACME certificates deployed for XMPP and Prosody restarted"
  fi

  return 0
}
