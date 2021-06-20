server {
    listen 8080;
    location / {
         proxy_pass ${IP_ADDRESS}:80
    }
 }
