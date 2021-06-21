#!/bin/bash
if [ -z ${APP+x} ]; then
  echo "You need to provide app name => APP='some-name'"
else
echo "Starting $APP"
 
cd prod
pwd
docker-compose up -d
cd ../test
docker-compose up -d
until [ "`docker inspect -f {{.State.Running}} wordpress_prod`"=="true" ]; do
    sleep 0.1;
done;
cd ..
chmod 666 ./prod/wp_data/html/wp-admin/install.php
chown su:su ./prod/wp_data/html/wp-admin/install.php
echo 'This is a production site: $APP' > ./prod/wp_data/html/wp-admin/install.php
until [ "`docker inspect -f {{.State.Running}} wordpress_test`"=="true" ]; do
    sleep 0.1;
done;
chmod 666 ./test/wp_data/html/wp-admin/install.php
chown su:su ./test/wp_data/html/wp-admin/install.php
echo 'This is a test site $APP' > ./test/wp_data/html/wp-admin/install.php
fi
