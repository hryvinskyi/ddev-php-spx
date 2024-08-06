#!/usr/bin/env bash
#ddev-generated

add_directives() {
	local FILE_PATH="$1"
	local PHP_VERSIONS=("5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.1" "8.2" "8.3" "8.4")

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

# Define the file path
DOCKERFILE="web-build/Dockerfile.php-spx"

if [ -e "$DOCKERFILE" ]; then
	rm -f "$DOCKERFILE" >/dev/null
fi

add_directives "$DOCKERFILE"