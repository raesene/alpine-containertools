FROM alpine:3.5
MAINTAINER Rory McCune <rorym@mccune.org.uk>

ENTRYPOINT ["/entrypoint.sh"]

RUN apk --update add openssh nmap nmap-scripts curl tcpdump bind-tools jq nmap-ncat && \
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && rm -rf /var/cache/apk/*


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
