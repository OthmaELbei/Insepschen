FROM debian:12

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/oelbied.42.fr.key \
    -out /etc/nginx/ssl/oelbied.42.fr.crt \
    -subj "/CN=oelbied.42.fr"


COPY conf/nginx.conf /etc/nginx/sites-available/default

CMD ["nginx","-g","daemon off;"]