FROM alpine
MAINTAINER me
RUN set -xe; \
  \
  apk add --update --no-cache \
    ca-certificates curl gzip tar unzip wget nginx openssl bind-tools;
RUN mkdir -p /run/nginx
COPY default.conf /etc/nginx/conf.d/
COPY index.html /var/www/localhost/htdocs
ADD --chown=root:root .profile /root
ADD --chown=root:root testfile /root
ENV ENV="/root/.profile"
CMD ["nginx", "-g", "daemon off;"]
