FROM wordpress:php8.2-apache

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        autoconf \
        g++ \
        make \
        pkg-config; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug; \
    apt-get purge -y --auto-remove \
        autoconf \
        g++ \
        make \
        pkg-config; \
    rm -rf /var/lib/apt/lists/*

COPY docker/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/99-xdebug.ini

ENV XDEBUG_MODE=debug \
    XDEBUG_CONFIG="client_port=9003" \
    PHP_IDE_CONFIG="serverName=wordpress"

WORKDIR /var/www/html
