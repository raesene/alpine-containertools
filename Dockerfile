FROM alpine:3.7
MAINTAINER Rory McCune <rorym@mccune.org.uk>



RUN apk --update add openssh nmap nmap-scripts curl tcpdump bind-tools jq nmap-ncat && \
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && rm -rf /var/cache/apk/*

#Get kubectl modify the version for later ones, and damn but this is a big binary! this is 16 for older clusters
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.6.12/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl16

#Another Kubectl need different versions as the older clusters won't work with newer clients
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

#Get docker we're not using the apk as it includes the server binaries that we don't need
RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz && tar -xzvf docker-17.04.0-ce.tgz && \
cp docker/docker /usr/local/bin && chmod +x /usr/local/bin/docker && rm -rf docker/ && rm -f docker-17.04.0-ce.tgz

#Get etcdctl
RUN curl -OL https://github.com/coreos/etcd/releases/download/v3.1.5/etcd-v3.1.5-linux-amd64.tar.gz && \
tar -xzvf etcd-v3.1.5-linux-amd64.tar.gz && cp etcd-v3.1.5-linux-amd64/etcdctl /usr/local/bin && \
chmod +x /usr/local/bin/etcdctl && rm -rf etcd-v3.1.5-linux-amd64 && rm -f etcd-v3.1.5-linux-amd64.tar.gz

#Copy the bolt browser binary in.
COPY boltbrowser /usr/local/bin

#Get AmIcontained
RUN curl -OL https://github.com/jessfraz/amicontained/releases/download/v0.0.8/amicontained-linux-amd64 && \
cp amicontained-linux-amd64 /usr/local/bin/amicontained && chmod +x /usr/local/bin/amicontained

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

#We can run this but lets let it be overridden with a CMD 
CMD ["/entrypoint.sh"]
