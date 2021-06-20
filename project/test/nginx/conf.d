server {
    listen 80;
    location / {
         proxy_pass ${IP_ADDRESS}:80
    }
 }
