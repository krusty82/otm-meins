#!/bin/sh
set -e

if [ ! -d "/var/lib/postgresql/14/main" ]; then
  pg_dropcluster 14 main
  mkdir -p /var/lib/postgresql
  chown -R postgres /var/lib/postgresql
  pg_createcluster 14 main

  /etc/init.d/postgresql start
fi

if [ ! -d "/mnt/tiles" ]; then
  mkdir -p /mnt/tiles/opentopomap
  mkdir -p /mnt/tiles/example
  chmod -R 777 /mnt/tiles
fi

/etc/init.d/postgresql start
#/etc/init.d/rsyslog start
#sudo mkdir /var/run/tirex
#sudo chown -R tirex:tirex /var/run/tirex
sudo -u tirex tirex-backend-manager start
sudo -u tirex tirex-master start
#/etc/init.d/ssh start



# Starte rsyslog (optional, für Logging)
#rsyslogd





sed -i 's/$SERVER_NAME/'"$DOMAIN"'/g' /etc/apache2/sites-available/tileserver_site.conf
sed -i 's/$WHITELIST/'"$WHITELIST"'/g' /etc/apache2/sites-available/tileserver_site.conf
sed -i 's/$DOMAIN/'"$DOMAIN"'/g' /var/www/index.html
a2ensite tileserver_site.conf

if [ "$LETSENCRYPT" = "1" ]; then
  certbot -n --apache --cert-name mapserver --redirect --agree-tos --email "$EMAIL" --domain "$DOMAIN"
fi

#if [ "$MOD_TILE_PREVENT_EXPIRATION" = "1" ]; then
#  touch -d '10 years ago' /var/lib/mod_tile/planet-import-complete
#fi

apachectl stop
sleep 10
apachectl -DFOREGROUND
