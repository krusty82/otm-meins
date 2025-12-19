FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Basis-Installation
RUN apt-get update && apt-get install -y \
    sudo git curl wget nano screen rsyslog unzip \
    build-essential clang make cmake pkg-config autoconf debhelper devscripts \
    zlib1g-dev libbz2-dev libgeos-dev libpq-dev libproj-dev \
    libjson-perl libipc-sharelite-perl libgd-perl \
    python3 python3-pip python3-setuptools python3-mapnik \
    python3-numpy python3-gdal python3-matplotlib python3-bs4 \
    apache2 apache2-dev \
    postgresql postgis postgresql-contrib \
    libmapnik3.1 libmapnik-dev mapnik-utils \
    lua5.3 liblua5.3-dev \
    gdal-bin unifont locales

# Lokalisierung / UTF-8
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8


# tirex (z. B. Version 0.6.1)
#RUN apt-get install -y tirex
#RUN apt-get update && apt-get install -y devscripts
RUN git clone https://github.com/geofabrik/tirex /home/tirex && \
    cd /home/tirex && git checkout 9c52ce1 && make && make deb && cd /home && \
    dpkg -i tirex-core_0.6.1_amd64.deb && \
    dpkg -i tirex-backend-mapnik_0.6.1_amd64.deb && \
    dpkg -i tirex-syncd_0.6.1_amd64.deb

# mod_tile (z. B. Version 0.4)
RUN apt-get install -y libapache2-mod-tile renderd
RUN   mkdir /mnt/tiles && rm -rf /var/lib/tirex/tiles && rm -rf /var/lib/mod_tile && ln -s /mnt/tiles /var/lib/tirex/tiles && ln -s /mnt/tiles /var/lib/mod_tile



# osm2pgsql
RUN apt-get install -y osm2pgsql

# pyhgtmap
RUN pip3 install pyhgtmap
RUN pip3 install class_registry==2.1.1

# nik4
RUN wget -O /usr/local/bin/nik4.py https://raw.githubusercontent.com/Zverik/Nik4/master/nik4.py && \
    chmod 755 /usr/local/bin/nik4.py

# Projekt-Assets kopieren
COPY assets /

# Apache-Module aktivieren
RUN a2dismod mpm_event && \
    a2enmod mpm_prefork headers tile proxy proxy_http proxy_balancer ssl rewrite

# Umgebungsvariablen
ENV LETSENCRYPT=0
ENV EMAIL=admin@localserver.net
ENV DOMAIN=otm-docker.example.io
ENV WHITELIST=127.0.0.1
ENV MOD_TILE_PREVENT_EXPIRATION=0

# Ports freigeben
EXPOSE 80
EXPOSE 443

# Start-Skript
ENTRYPOINT ["/usr/local/bin/startup.sh"]

