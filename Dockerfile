FROM alpine:latest

RUN adduser -D ircd -s /bin/false ircd
WORKDIR /home/ircd

RUN apk --update add \
  ca-certificates gcc libc-dev make openssl-dev tar wget \
  && wget http://www.ircd-hybrid.org/snapshot/ircd-hybrid-8.2.x-STABLE-20170419_8242.tgz \
  && tar xf *.tgz \
  && rm *.tgz \
  && cd ircd-hybrid* \
  && ./configure --prefix /home/ircd/; cat config.log \
  && make \
  && make install \
  && cd .. \
  && rm -rf ircd-hybrid* \
  && apk del gcc \
  && rm -rf /var/cache/apk/* \
  && chown -R ircd:ircd *

USER ircd

CMD ["/home/ircd/bin/ircd","-foreground"]

