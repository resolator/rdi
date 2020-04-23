# rdi - Resolator Docker Image
Resolator Docker Image - image for efficient and comfortable in-docker development. 

This image aimed on DL and CV development and based on [nvidia/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/ubuntu18.04) images.

## Usage
### Build
If you want to build this image directly you can use the following command:
```shell script
cd context
docker build --build-arg cuda_version=10.2 --build-arg cudnn_set=runtime .
```

Now it support:
```shell script
cuda_version: "9.2", "10.0", "10.1", "10.2"
cudnn_set: "runtime", "devel"
```

### Run
Minimal command for launch this dockers correctly:
```sh
docker run --runtime nvidia -e UNAME=$(whoami) -e UID=$(id -u) -e GID=$(id -g) -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it resolator/simple-docker-image:cuda10.2-runtime-cudnn7
```

Don't forget to name your container:
```sh
--name cuda_10.2_X11
```
Forward some ports:
```sh
-p 9999:9999
```
And mount some volumes:
```sh
-v /home/username/data:/data
-v /home/username/repos:/repos
```
It's also recommended to increase the size of shared memory:
```sh
--shm-size 8G
```

### Interaction
After you have run the docker you are supposed to be in container's terminal. This image uses the [attach-detach](https://docs.docker.com/engine/reference/commandline/attach/) mechanism, so if you want to leave it running use the following key sequence: `CTRL+P+Q`. For attach back use the `docker attach <container>` command.

If you use this image every day it's useful to make an alias in your `.bashrc` file:
```sh
alias rdrun='docker run --runtime nvidia --shm-size 8G -e UNAME=$(whoami) -e UID=$(id -u) -e GID=$(id -g) -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it'
```
If you want to keep the completion working for docker run command even in this alias you can find a way in [this](https://github.com/resolator/tdc) project.

## Features
- Copied user from the host machine (now any in-docker created files will have your user's attributes). 
- Pre-installed cuda (for ML development).
- Pre-installed libraries for install `opencv-python`.
- Upgraded pip to 19.3.1 and some preinstalled utils.
- Fixed history search in terminal (start entering your command and navigate on history using up/down arrows).
- When you inside docker the prompt starts from ":whale: ".
- Pre-installed configs for better in-terminal development form [this](https://github.com/resolator/tdc) project.
- Forwarded displaying windows from container to host machine (host system must have a running X11 server).
