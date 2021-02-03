# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/30 18:31:46 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/03 15:20:03 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# Specify container OS.
FROM debian:buster

# Copy source files to working directory.
COPY srcs/. /root/

# Install packages.
RUN apt-get update
RUN apt-get -y install wget apt-utils

# Install NginX.
RUN apt-get -y install nginx

# Install MariaDB.
RUN apt-get -y install mariadb-server

# Install PHP and phpMyAdmin.
RUN apt-get -y install php php-mysql php-fpm php-cli php-mbstring php-gd php-cgi

# Install SSL certificate.
RUN apt-get -y install libnss3-tools
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64

# Install Wordpress

RUN wget https://wordpress.org/latest.tar.gz
RUN mkdir /var/www/html/wordpress
RUN tar xzvf latest.tar.gz -C /var/www/html/wordpress

# RUN cp -a wordpress/. /var/www/html

# Configure SSL certificate.
RUN chmod 777 ./mkcert-v1.4.3-linux-amd64
RUN ./mkcert-v1.4.3-linux-amd64 localhost
RUN rm -rf ./mkcert-v1.4.3-linux-amd64
RUN cp ./localhost.pem /etc/nginx
RUN cp ./localhost-key.pem /etc/nginx

# Install and configure phpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz


# RUN mv /mkcert-v1.4.3-linux-amd64 /certs/mkcert
# RUN	chmod 777 /certs/mkcert
# RUN mv /certs/mkcert localhost
# RUN rm -rf /certs/mkcert


# Configure NginX.
# RUN cp /root/index.html /var/www/html
# RUN cp /root/index.sh .
RUN cp /root/nginx.conf /etc/nginx/sites-available
RUN ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled
RUN nginx -t

# Start services inside image

EXPOSE 80 443