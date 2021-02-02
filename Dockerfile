# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/30 18:31:46 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/02 16:35:34 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# Specify container OS.
FROM debian:buster

# Copy source files to working directory.
COPY srcs/. /root/

# Install updates, wget, and apt-utils.
RUN apt-get -y update
RUN apt-get -y install wget
RUN apt-get -y install apt-utils

# Install NginX.
RUN apt-get -y install nginx

# Install MariaDB.
# RUN apt-get -y install mariadb-server

# Install PHP.
RUN apt-get -y install php php-mysql php-fpm php-cli php-mbstring php-gd php-cgi

# Install SSL certificate.
RUN apt-get -y install libnss3-tools
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64

# Configure SSL certificate.
RUN mv mkcert-v1.4.3-linux-amd64 mkcert
RUN chmod 777 mkcert
RUN ./mkcert localhost
RUN rm -rf mkcert
RUN mv ./localhost.pem ./etc/nginx
RUN mv ./localhost-key.pem ./etc/nginx

# Configure NginX.
RUN mv /root/index.html /var/www/html
RUN mv /root/index.sh .
RUN mv /root/nginx.config /etc/nginx/sites-available
RUN ln -fs /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled
RUN nginx -t