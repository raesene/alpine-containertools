FROM alpine:3.5
MAINTAINER Rory McCune <rorym@mccune.org.uk>

ENTRYPOINT ["/entrypoint.sh"]

RUN apk --update add openssh nmap nmap-scripts curl tcpdump bind-tools jq nmap-ncat && \
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && rm -rf /var/cache/apk/*

#Get kubectl modify the version for later ones, and damn but this is a big binary!
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin

#Get docker we're not using the apk as it includes the server binaries that we don't need
RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz && tar -xzvf docker-17.04.0-ce.tgz && \
cp docker/docker /usr/local/bin && chmod +x /usr/local/bin/docker && rm -rf docker/ && rm -f docker-17.04.0-ce.tgz

#Get etcdctl
RUN curl -OL https://github.com/coreos/etcd/releases/download/v3.1.5/etcd-v3.1.5-linux-amd64.tar.gz && \
tar -xzvf etcd-v3.1.5-linux-amd64.tar.gz && cp etcd-v3.1.5-linux-amd64/etcdctl /usr/local/bin && \
chmod +x /usr/local/bin/etcdctl && rm -rf etcd-v3.1.5-linux-amd64 && rm -f etcd-v3.1.5-linux-amd64.tar.gz

#Copy the bolt browser binary in.
COPY boltbrowser /usr/local/bin

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
