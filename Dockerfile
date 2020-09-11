FROM alpine:latest

ARG TZ='Europe/Brussels'

ENV TZ ${TZ}

RUN apk update && apk add --no-cache bash tftp-hpa runit

RUN mkdir /tftpboot /runit-services /runit-services/tftpd-hpa /runit-services/syslogd

RUN echo -e "#!/bin/sh\nbusybox syslogd -n -O /var/log/tftpd.log" > /runit-services/syslogd/run && \
    echo -e "#!/bin/sh\nin.tftpd --foreground --verbose --verbose --verbose --secure --create --ipv4 /tftpboot" > \
        /runit-services/tftpd-hpa/run

RUN chmod +x /runit-services/syslogd/run /runit-services/tftpd-hpa/run && \
    rm -rf /tmp/* /var/tmp/*

VOLUME /tftpboot, /var/log/tftpd.log

EXPOSE 69/udp

ENTRYPOINT ["runsvdir", "/runit-services"]
