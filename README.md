Alpine Container Tools Docker Image
--

I had a need for a container that'll keep running as a service and have some common networking and container tools in it.
Also need something which doesn't have a default password, so this will generate a random one.

Based on alpine to keep the image nice and small.

Setup based on ideas from https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/ssh/entrypoint.sh and
https://github.com/sickp/docker-alpine-sshd/blob/master/versions/7.4/Dockerfile

Tools installed
--
openssh
nmap
curl
etcd
kubectl
docker client


Running Instructions
--
`docker run -d -p 2200:22 raesene/alpine-nettools`

`docker ps` - Get the container name

`docker logs <container>` to get the root password

`ssh root@<ip>` 
