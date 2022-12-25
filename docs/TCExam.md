```
$ docker run --rm --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -e PGDATA=/var/lib/postgresql/data/pgdata --network host postgres
```


```
$ docker run --rm -p8000:80 -it debian:bullseye-slim bash

# apt install acpid apache2 ghostscript gsfonts imagemagick libapache2-mod-auth-pgsql libapache2-mod-auth-plain libapache2-mod-php libauthen-pam-perl libio-pty-perl  libnet-ssleay-perl libpam-runtime lm-sensors openssl perl php php-cli php-intl php-gd php-imagick php-curl php-pgsql php-xml php-memcache postgresql postgresql-client postgresql-contrib ssh texlive-base zbar-tools vim unzip less

# unzip tcexam-main.zip
# cp -r tcexam-main/* /var/www/html/
# chown -R www-data /var/www/html/
# apache2ctl start
# cd /var/www/html/
# for i in  {public,shared,admin}; do echo $i; mv $i/config.default $i/config  ; done
# cd shared/config
# vim tce_paths.php
# vim tce_db_config.php


shared/config/tce_db_config.php
    K_DATABASE_TYPE (database type, usually MYSQL or POSTGRESQL)
    K_DATABASE_HOST (name of the database host, usually localhost)
    K_DATABASE_NAME (database name, usually TCExam)
    K_DATABASE_USER_NAME (name of the database user, it usually is root)
    K_DATABASE_USER_PASSWORD (password to access the database)
    K_TABLE_PREFIX (prefix that will be added to the table names, usually tce_)
define('K_DATABASE_TYPE', 'POSTGRESQL');
define('K_DATABASE_HOST', '192.168.0.150');
define('K_DATABASE_PORT', '5432');
define('K_DATABASE_NAME', 'tcexam');
define('K_DATABASE_USER_NAME', 'postgres');
define('K_DATABASE_USER_PASSWORD', 'mysecretpassword');

shared/config/tce_paths.php
    K_PATH_HOST (the domain name of your site, i.e. http://www.yoursite.com)
    K_PATH_TCEXAM (relative path from the root of your webserver 
                  where the TCExam files are located, usually / or /tcexam_folder/)
    K_PATH_MAIN (complete path to the folder
                where TCExam is installed, 
                i.e. /usr/local/apache/htdocs/TCExam/ or
                      c:/Inetpub/wwwroot/TCExam/)
    K_STANDARD_PORT (http communication port, usually 80 or 443 for SSL)
define('K_PATH_HOST', 'http://localhost:8000');
define('K_PATH_TCEXAM', '/');
define('K_PATH_MAIN', '/var/www/html/');
define('K_STANDARD_PORT', 8000);

# psql -h  192.168.0.150 -U postgres -c 'CREATE DATABASE tcexam;'
# psql -h  192.168.0.150 -U postgres tcexam < install/postgresql_db_structure.sql
```
