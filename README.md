# rdi - Resolator Docker Image
Resolator Docker Image - image extras for efficient and comfortable in-docker 
development. 

This image is aimed at in-docker development and supposed to be based on 
[nvidia/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/ubuntu18.04) 
images or 
[ubuntu:18.04](https://hub.docker.com/_/ubuntu) image, but you can try any 
debian images.

## Usage
### Build
Some pre-built images you can find 
[here](https://hub.docker.com/r/resolator/rdi).

If you want to build this image directly you can use the following command:
```shell script
cd context
docker build --build-arg parent="PARENT_IMAGE_NAME" .
```

The `PARENT_IMAGE_NAME` suppoosed to be replaced with your parent image. For 
example:
```shell script
docker build --build-arg parent="nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04" .
```

### Run
Minimal command for launch this dockers correctly:
```shell script
docker run -e TERM=$TERM -e UNAME=$(whoami) -e UID=$(id -u) -e GID=$(id -g) -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it IMAGE_NAME
```

Don't forget to name your container:
```shell script
--name cuda_10.2_X11
```
Forward some ports:
```shell script
-p 9999:9999
```
And mount some volumes:
```shell script
-v $HOME/data:/data
-v $HOME/repos:/repos
```
It's also recommended to increase the size of shared memory:
```shell script
--shm-size 8G
```
If you want to forward your localtime to the container:
```shell script
-v /etc/localtime:/etc/localtime:ro
```

### Interaction
After you have run the docker you are supposed to be in container's terminal. 
This image uses the 
[attach-detach](https://docs.docker.com/engine/reference/commandline/attach/) 
mechanism, so if you want to leave it running use the following key sequence: 
`CTRL+P+Q`. For attach back use the `docker attach <container>` command.

If you use this image very often it's useful to make an alias in your 
`.bashrc` file:
```shell script
alias rdrun='docker run --gpus all --shm-size 8G -e TERM=$TERM -e UNAME=$(whoami) -e UID=$(id -u) -e GID=$(id -g) -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/localtime:/etc/localtime:ro -v $HOME/data:/data -v $HOME/repos:/repos -it'
```
If you want to keep the completion working for docker run command even in this 
alias you can find a way in [tdc repo](https://github.com/resolator/tdc).

## Features
- Copied user from the host machine (now any in-docker created files will have 
your user's attributes). 
- The base image can be selected (tested on ubuntu:18.04 and some nvidia/cuda 
images).
- Upgraded pip to 20.1 and some preinstalled utils (like git, curl, etc.).
- Fixed history search in terminal (start entering your command and navigate 
on history using up/down arrows).
- When you inside docker the prompt starts from ":whale: ".
- Pre-installed configs for better in-terminal development form 
[tdc repo](https://github.com/resolator/tdc).
- Forwarded (for alias) displaying windows from container to host machine 
(host system must have a running X11 server).
