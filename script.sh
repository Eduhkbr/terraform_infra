sudo apt-get update
sudo apt install -y mysql-server-5.7
sudo cp /tmp/mysql/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql < /tmp/mysql/user.sql
sudo service mysql restart