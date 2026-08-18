#!/bin/bash

set -e

mkdir -p "/var/www/html"

cd /var/www/html

if [ ! -f index.php ]; then
     wp core download --allow-root
fi

sed -i  's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

until mysqladmin ping -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"  --silent; do
    sleep 1
done

if [ ! -f wp-config.php ]; then
	wp config create \
	  --dbname=$MYSQL_DATABASE \
	  --dbuser=$MYSQL_USER \
	  --dbpass=$MYSQL_PASSWORD \
	  --dbhost=mariadb \
	  --allow-root
fi

if ! wp core is-installed --allow-root >/dev/null 2>&1; then
	wp core install \
	  --url=$DOMAIN_NAME \
	  --title=$WP_TITLE \
	  --admin_user=$WP_ADMIN_USER \
	  --admin_password=$WP_ADMIN_PASSWORD \
	  --admin_email=$WP_ADMIN_EMAIL \
	  --allow-root

	 wp user create \
		$WP_USER \
	        $WP_USER_EMAIL \
	       --user_pass=$WP_USER_PASSWORD \
	       --role=author \
	       --allow-root 
fi

exec php-fpm8.2 -F
