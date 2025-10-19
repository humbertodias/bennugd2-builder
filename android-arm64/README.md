```shell
docker build --platform linux/amd64 -t android-ndk:27 .
docker run --platform linux/amd64 -it -v `pwd`:/workspace android-ndk:27 bash
````