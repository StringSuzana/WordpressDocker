server {
    listen 8080;
    location / {
         proxy_pass backend_prod:80
    }
 }
