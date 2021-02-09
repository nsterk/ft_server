# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/30 18:31:46 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/09 22:21:37 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# Specify container OS.
FROM debian:buster

# Install packages & software.
RUN apt-get update && apt-get upgrade -y && \
	apt-get -y install wget apt-utils libnss3-tools \
	nginx mariadb-server \
	php-fpm php-mysql php-cli php-mbstring php-gd php-zip

# Copy source files to root.
COPY srcs/. /root/

# Install and configure SSL certificate.	
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 && \
	chmod +x ./mkcert-v1.4.3-linux-amd64 && \
	./mkcert-v1.4.3-linux-amd64 localhost && \
	rm -rf ./mkcert-v1.4.3-linux-amd64 && \
	mv ./localhost.pem /etc/nginx && \
	mv ./localhost-key.pem /etc/nginx

# Configure NginX.
RUN mv /root/index.html /var/www/html/ && \
	mv /root/nginx.conf /etc/nginx/sites-available/ && \
	ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/ && \
	rm -rf /etc/nginx/sites-enabled/default && \
	nginx -t

# Create index.php
RUN touch /var/www/html/index.php && \
	echo "<?php phpinfo(); ?>" >> /var/www/html/index.php

# Configure SQL database.
RUN bash /root/mysql.sh

# Install and configure phpMyAdmin.
RUN mkdir /var/www/html/phpmyadmin/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz && \
	tar xzfv phpMyAdmin-5.0.4-english.tar.gz -C /root
RUN cp -a /root/phpMyAdmin-5.0.4-english/. /var/www/html/phpmyadmin/ && \
	rm -rf /root/phpMyAdmin-5.0.4-english && \
	rm -rf phpMyAdmin-5.0.4-english.tar.gz && \
	mv /root/config.inc.php /var/www/html/phpmyadmin

# Install and configure Wordpress.
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xzvf latest.tar.gz -C /var/www/html/ && \
	rm -rf latest.tar.gz && \
	mv /root/wp-config.php /var/www/html/wordpress/

# Configure permissions.
RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*

EXPOSE 80 443

# Start services.
CMD service mysql restart && service php7.3-fpm start && nginx -g 'daemon off;'
