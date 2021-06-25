if [ -z ${APP+x} ]
then
  echo "You need to provide app name => APP='some-name'"
else
echo "Starting $APP"
echo "Starting ${APP}"

cd prod
sudo mkdir wp_data
sudo mkdir db_data
pwd
docker-compose up -d
cd ../test
sudo mkdir wp_data
sudo mkdir db_data
docker-compose up -d
until [ "`docker inspect -f {{.State.Running}} wordpress_prod`"=="true" ]
do
    echo "."
    sleep 1
done
cd ..

while [ ! -f ./prod/wp_data/html/wp-admin/install.php ]
do
  echo "."
  sleep 1
done
    echo "Writing to production site"
chmod 666 ./prod/wp_data/html/wp-admin/install.php
chown root:root ./prod/wp_data/html/wp-admin/install.php
echo "This is a production site: ${APP}" > ./prod/wp_data/html/wp-admin/install.php
chown www-data:www-data ./prod/wp_data/html/wp-admin/install.php
until [ "`docker inspect -f {{.State.Running}} wordpress_test`"=="true" ]
do
    echo "."
    sleep 1
done
while [ ! -f ./test/wp_data/html/wp-admin/install.php ]
do
  echo "."
  sleep 1
done
echo "Writing to test site."
chmod 666 ./test/wp_data/html/wp-admin/install.php
chown root:root ./test/wp_data/html/wp-admin/install.php
echo "This is a test site ${APP}" > ./test/wp_data/html/wp-admin/install.php
chown www-data:www-data ./test/wp_data/html/wp-admin/install.php
fi
