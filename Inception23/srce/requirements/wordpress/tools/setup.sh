#!/bin/bash

set -e

mkdir -p "/var/www/html"
# -p not write any error if this file aredie hear
cd /var/www/html

if [ ! -f index.php ]; then
     wp core download --allow-root
fi
# wp-cli fors donet give any error for worker --allow-root tak all the bermeiechen of the root tak this permechen bckos the is run in the contener and this separe for all

sed -i  's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# sed stream Editor
# -i in-plase all this change i want hear 

until mysqladmin ping -h mariadb --silent; do
    sleep 1
done
# mysqladmin 
if [ ! -f wp-config.php ]; then
	wp config create \
	  --dbname=$MYSQL_DATABASE \
	  --dbuser=$MYSQL_USER \
	  --dbpass=$MYSQL_PASSWORD \
	  --dbhost=mariadb \
	  --allow-root
fi
# Database 

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
