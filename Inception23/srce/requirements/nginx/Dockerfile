FROM debian:12

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/oelbied.42.fr.key \
    -out /etc/nginx/ssl/oelbied.42.fr.crt \
    -subj "/C=MA/ST=Casablanca/L=Casablanca/0=42/OU=42/CN=oelbied.42.fr"

EXPOSE 443

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx","-g","daemon off;"]
