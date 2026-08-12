FROM debian:12

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    curl
	
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

CMD ["/setup.sh"]
