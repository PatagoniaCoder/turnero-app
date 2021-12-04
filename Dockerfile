FROM alpine:3.15

# Set working directory.
RUN mkdir /app
WORKDIR /app

# Install ruby

RUN apk update \
    && apk add ruby postgresql14
RUN mkdir /run/postgresql \
    && chown postgres:postgres /run/postgresql/
USER postgres
RUN mkdir /var/lib/postgresql/data \
    && chmod 0700 /var/lib/postgresql/data \
    && initdb -D /var/lib/postgresql/data \
    && echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf \
    && echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

ENTRYPOINT pg_ctl start -D /var/lib/postgresql/data && sh
