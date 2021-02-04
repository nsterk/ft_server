# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/30 18:31:46 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/04 11:43:06 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# Specify container OS.
FROM debian:buster

# Copy source files to working directory.
COPY srcs/. /root/

# Install packages.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install wget apt-utils

# Install NginX.
RUN apt-get -y install nginx 

# Install MySQL.
RUN apt-get -y install mariadb-server

# Install PHP packages.
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl \
	php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap

# Install and configure SSL certificate.
RUN apt-get -y install libnss3-tools
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64
RUN chmod +x ./mkcert-v1.4.3-linux-amd64
RUN ./mkcert-v1.4.3-linux-amd64 localhost
RUN rm -rf ./mkcert-v1.4.3-linux-amd64
RUN cp ./localhost.pem /etc/nginx
RUN cp ./localhost-key.pem /etc/nginx

# Install Wordpress
RUN service mysql start
RUN wget https://wordpress.org/latest.tar.gz
RUN mkdir /var/www/html/wordpress
RUN tar xzvf latest.tar.gz -C /var/www/html/wordpress
RUN rm -rf latest.tar.gz
RUN cp /root/wp-config.php /var/www/html/wordpress

# Configure NginX.
RUN cp /root/index.html /var/www/html
RUN cp /root/nginx.conf /etc/nginx/sites-available
RUN ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled
RUN nginx -t

# Install and configure phpMyAdmin.
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar xzfv phpMyAdmin-5.0.4-english.tar.gz -C /root
RUN mkdir /var/www/html/phpmyadmin
RUN cp -a /root/phpMyAdmin-5.0.4-english/. /var/www/html/phpmyadmin/
RUN rm -rf /root/phpMyAdmin-5.0.4-english
RUN rm -rf phpMyAdmin-5.0.4-english.tar.gz
RUN cp /root/config.inc.php /var/www/html/phpmyadmin

# Grant permissions.
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 80 443

# Create database for Wordpress and configure MySQL.
CMD bash /root/init.sh
