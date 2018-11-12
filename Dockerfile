FROM alpine:3.8

ARG BUILD_DATE=0000-00-00
ARG VCS_REF=undef

ENV CONSUL_TEMPlATE_VERSION=0.19.5
ENV CONSUL_TEMPlATE_SHA256SUMS=e6b376701708b901b0548490e296739aedd1c19423c386eb0b01cfad152162af
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://gitlab.dobrev.eu/docker/haproxy-consul-template.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="Dobrev IT LTD." \
      org.label-schema.name="haproxy-consul-template" \
      org.label-schema.description="Docker image with HAproxy, consul-template and Alpine" \
      org.label-schema.url="https://gitlab.dobrev.eu/docker/haproxy-consul-template"

ENV DEPS="curl \
        ca-certificates \
        haproxy \
        unzip \
        wget \
        runit"

RUN apk --no-cache --update add $DEPS \
    && wget -O /tmp/consul-template_${CONSUL_TEMPlATE_VERSION}_linux_amd64.zip \
         https://releases.hashicorp.com/consul-template/${CONSUL_TEMPlATE_VERSION}/consul-template_${CONSUL_TEMPlATE_VERSION}_linux_amd64.zip \
    && echo "$CONSUL_TEMPlATE_SHA256SUMS  /tmp/consul-template_${CONSUL_TEMPlATE_VERSION}_linux_amd64.zip" | sha256sum -c - \
    && unzip /tmp/consul-template_${CONSUL_TEMPlATE_VERSION}_linux_amd64.zip \
    && mv consul-template /usr/local/bin/ \
    && rm -rf /tmp/consul-template_${CONSUL_TEMPlATE_VERSION}_linux_amd64.zip \
    && apk del curl wget unzip

EXPOSE 80 8080 1275 1936

COPY ./.docker/base /

CMD ["/sbin/runit-wrapper"]
