#!/usr/bin/env bash
#ddev-generated

add_directives() {
	local FILE_PATH="$1"

	cat <<EOF >>"$FILE_PATH"
# BEGIN PHP-SPX Install

RUN npm install --global forever
RUN echo "Built on $(date)" > /build-date.txt

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends --no-install-suggests make php${DDEV_PHP_VERSION}-dev zlib1g-dev
RUN mkdir -p /tmp/php-spx && cd /tmp/php-spx && git clone -b release/latest https://github.com/NoiseByNorthwest/php-spx.git . &&  phpize && ./configure && make && make install
RUN echo "extension=spx.so" > /etc/php/$DDEV_PHP_VERSION/mods-available/spx.ini

# END PHP-SPX Install
EOF
}

add_phpini() {
	local FILE_PATH="$1"

	cat <<EOF >>"$FILE_PATH"

extension=spx.so;
zlib.output_compression = 0
spx.http_enabled = 1
spx.http_key = "dev"
spx.http_ip_whitelist = "*"
spx.data_dir = /var/www/spx_dumps

EOF
}

# Define the file path
DOCKERFILE="web-build/Dockerfile.php-spx"
PHPINIFILE="php/spx-php.ini"

if [ -e "$DOCKERFILE" ]; then
	rm -f "$DOCKERFILE" >/dev/null
fi

if [ -e "$PHPINIFILE" ]; then
	rm -f "$PHPINIFILE" >/dev/null
fi

add_directives "$DOCKERFILE"
add_phpini "$PHPINIFILE"
