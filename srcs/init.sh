# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    init.sh                                            :+:    :+:             #
#                                                      +:+                     #
#    By: nsterk <nsterk@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2021/02/03 16:18:45 by nsterk        #+#    #+#                  #
#    Updated: 2021/02/03 20:35:51 by nsterk        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

service nginx start
service mysql start
service php7.3-fpm start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'naomi'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'naomi'@'localhost' = PASSWORD('password');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'naomi'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "update mysql.user set plugin='mysql_native_password' where user='naomi';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

bash