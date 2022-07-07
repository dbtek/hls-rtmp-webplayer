## hls-rtmp-webplayer
RTMP server and hls player with SSL support.

### Run with Docker Compose

1. Save `docker-compose.yml` file into a directory.
2. Update `example.com` domain name usages inside `docker-compose.yml`.
3. Create a `conf` directory.
```bash
mkdir conf
```
4. Run services. And wait for swag to generate ssl certs.
```bash
docker compose up
```
5. Stop services.
6. Place proxy config into `conf/nginx/site-conf/site.conf`.
```
server {
  listen 443 ssl;
  listen [::]:443 ssl;

  server_name example.com;

  include /config/nginx/ssl.conf;

  client_max_body_size 0;

  location / {
    include /config/nginx/proxy.conf;
    resolver 127.0.0.11 valid=30s;
    set $upstream_app player;
    set $upstream_port 80;
    set $upstream_proto http;
    proxy_pass $upstream_proto://$upstream_app:$upstream_port;
  }

  location /hls {
    include /config/nginx/proxy.conf;
    resolver 127.0.0.11 valid=30s;
    set $upstream_app rtmp;
    set $upstream_port 8080;
    set $upstream_proto http;
    proxy_pass $upstream_proto://$upstream_app:$upstream_port;
  }
}
```
7. Run services again.
```bash
docker compose up -d
```