# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    mysql.sh                                           :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/02/03 16:18:45 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/09 17:50:39 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'naomi'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'naomi'@'localhost' = PASSWORD('password');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'naomi'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
mysql wordpress -u root < /root/wordpress.sql
