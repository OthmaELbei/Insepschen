


FROM debian:12

RUN apt update && \
    apt install -y  mariadb-server && \
   rm -rf /var/lib/apt/lists/*

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

CMD ["/setup.sh"]
