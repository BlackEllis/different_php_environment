
#!/bin/sh

echo "CREATE USER 'add_user'@'%' IDENTIFIED BY 'passwd' ;" | "${mysql[@]}"
echo "CREATE DATABASE IF NOT EXISTS \`add_database_name\` ;" | "${mysql[@]}"
echo "GRANT ALL ON \`add_database_name\`.* TO 'add_user'@'%' ;" | "${mysql[@]}"
echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"

export MYSQL_PWD="passwd"
zcat /docker-entrypoint-initdb.d/add_database_dump.sql.gz_ | mysql -u add_user add_database_name
