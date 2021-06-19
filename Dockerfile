FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY ./project/prod/ng_data/conf.d /etc/nginx
