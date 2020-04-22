# rdi - Resolator Docker Image
Resolator Docker Image - repository with file for building customized docker 
images.

This image based on [nvidia/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/ubuntu18.04) images.

The `context` dir contains all needable files for `docker build` command.


## Usage
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

# Features
- When you inside docker the prompt starts from ":whale: ".
- README in progress...
