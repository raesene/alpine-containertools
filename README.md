# Alpine Container Tools Docker Image

This is an image with a load of common container tooling, for use when you need various containers tools :) It's generally targeted at security assessment tools.

# Tools installed

## General Tools

- **openssh** 
- **nmap**
- **curl**

## Container Tools

- **etcdctl** - useful for connecting to etcd instances
- **kubectl** - useful for connecting to Kubernetes API servers
  * There's also kubectl18 and kubectl112 for older clusters
- **docker** (client) - useful for connecting to Docker instances
- **helm2** and **helm3** - useful for deploying charts (see below) or querying Tiller services (with helm2)
- **amicontained** - https://github.com/genuinetools/amicontained/ - Tool to assess the environment your process is running in, for things like capabilities and seccomp filters that have been applied.
- **reg** - https://github.com/genuinetools/reg
- **conmachi** - https://github.com/nccgroup/conmachi - Similar to amicontained, handy tool for understanding the privileges of a container that you're running in
- **boltbrowser** - https://github.com/br0xen/boltbrowser - This is a tool for viewing BoltDB format databaes (which is used by etcd)
- **rakkess** - https://github.com/corneliusweig/rakkess - Tool for analyzing RBAC permissions
- **kubectl-who-can** - https://github.com/aquasecurity/kubectl-who-can - Tool for analyzing RBAC permissions
- **kube-hunter** - https://github.com/aquasecurity/kube-hunter - Tool for pentesting Kubernetes clusters
- **break-out-the-box** - https://github.com/brompwnie/botb - Tool for container analysis and exploitation

There are also some sample Helm Charts and manifests in `/charts` and `/manifests` respectively, which may be useful on tests remember to test these before use!


## Running Instructions

You can run this container with just a shell for interactive access with 

`docker run -it raesene/alpine-containertools /bin/bash`

Alternatively if you don't specify a command it'll launch an SSH server with a random password. To use this with a docker image first, `docker run -d -p 2200:22 raesene/alpine-containertools` then `docker ps` to get the container name, then `docker logs <container>` to get the root password, then `ssh root@<ip>` 


The SSH setup was based on ideas from https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/ssh/entrypoint.sh and
https://github.com/sickp/docker-alpine-sshd/blob/master/versions/7.4/Dockerfile
