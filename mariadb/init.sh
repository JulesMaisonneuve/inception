if [ ! -d "/var/lib/mysql/wordpress" ]; then
	service mysql start

	# Secure installation
	mysql -e "UPDATE mysql.user SET Password=PASSWORD('${DB_ROOT_PASSWORD}') WHERE User='root';"
	mysql -e "DELETE FROM mysql.user WHERE User='';"
	mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	mysql -e "DROP DATABASE IF EXISTS test;"
	mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
	mysql -e "FLUSH PRIVILEGES;"

	# Prevent unauthorized access from wordpress
	mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'localhost' WITH GRANT OPTION;"

	mysql -e "CREATE USER 'pierpol'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION;"

	# Apply changes
	mysql -e "FLUSH PRIVILEGES;"

	# Create database
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql ${DB_NAME} < /wordpress.sql

	# Set root password
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
	
fi
mysqld_safe