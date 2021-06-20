#!/bin/bash
sudo chown su:su ./prod/wp_data/html/wp-admin/install.php
sudo echo 'This is a production' > ./prod/wp_data/html/wp-admin/install.php
sudo chown su:su ./test/wp_data/html/wp-admin/install.php
sudo echo 'This is a test' > ./test/wp_data/html/wp-admin/install.php
