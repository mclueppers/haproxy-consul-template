FROM alpine:3.9

ARG BUILD_DATE=0000-00-00
ARG VCS_REF=undef

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://gitlab.dobrev.eu/docker/haproxy-consul-template.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="Dobrev IT LTD." \
      org.label-schema.name="haproxy-consul-template" \
      org.label-schema.description="Docker image with HAproxy, consul-template and Alpine" \
      org.label-schema.url="https://gitlab.dobrev.eu/docker/haproxy-consul-template"
ADD https://repos.dobrev.it/alpine/dobrevit.rsa.pub /etc/apk/keys/dobrevit.rsa.pub

ENV DEPS="curl \
        ca-certificates \
        consul-template \
        haproxy \
        netcat-openbsd \
        nginx \
        nginx-mod-http-headers-more \
        py3-envtpl \
        runit"

RUN echo "https://repos.dobrev.it/alpine/v3.9/" | tee -a /etc/apk/repositories \
    && apk --no-cache --update add $DEPS \
    && mkdir -p /run/nginx /run/haproxy \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 8080 1275 1396 1936

COPY ./.docker/base /

CMD ["/sbin/runit-wrapper"]
