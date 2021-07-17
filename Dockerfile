FROM nginx:stable-alpine
COPY index.html /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.d/30-app-entrypoint.sh
RUN rm /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/conf.d
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
