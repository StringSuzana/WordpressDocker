server {
    listen 8080;
    location / {
         proxy_pass frontend_prod:80
    }
 }
