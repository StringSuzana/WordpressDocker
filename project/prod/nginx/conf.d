server {
    listen 8080;
    location / {
         proxy_pass wordpress_prod:80
    }
 }
