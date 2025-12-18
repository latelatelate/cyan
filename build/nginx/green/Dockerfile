FROM nginx:latest
COPY conf.d/default.conf /etc/nginx/conf.d/green.conf
COPY index.html /usr/share/nginx/html/index.html
RUN rm /etc/nginx/conf.d/default.conf