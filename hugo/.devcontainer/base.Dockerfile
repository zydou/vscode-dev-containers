FROM alpine:edge

RUN apk update && \
    apk add --no-cache hugo
# Hugo dev server port
EXPOSE 1313
