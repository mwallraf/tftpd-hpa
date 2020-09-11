# TFTP DAEMON

Dockerized version of TFTPD-HPA based on alpine image.

To know all options: https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html

## DOCKER

Start container:

```
docker run --detach -p 69:69/udp -v /opt/tftpboot:/tftpboot --name tftpd mwallraf/tftpd-hpa:latest
```
