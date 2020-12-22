FROM alpine:edge
RUN apk add --no-cache kubectl
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
