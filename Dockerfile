FROM cortezaproject/corteza-server-corredor:2019.12.0 AS corredor
FROM cortezaproject/corteza-server:2019.12.0 AS server
FROM cortezaproject/corteza-webapp:2019.12.0 AS webapp
ENV VERSION=2019.12.0

WORKDIR /app

##### CORREDOR
RUN apk add --no-cache curl && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install 12.14.0 && \
    nvm use 12.14.0
RUN apk add --update --no-cache npm yarn ca-certificates

COPY --from=corredor /corredor .

##### SERVER

RUN mkdir /data
ENV COMPOSE_STORAGE_PATH   /data/compose
ENV MESSAGING_STORAGE_PATH /data/messaging
ENV SYSTEM_STORAGE_PATH    /data/system
VOLUME /data
COPY --from=server /bin/corteza-server /bin/

##### WEBAPP (we are in)

COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
