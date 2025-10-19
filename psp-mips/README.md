```shell
docker build -t pspsdk .
docker run --rm -it -v $(pwd)/hello:/workspace -w /workspace pspdev/pspdev bash
````

Generate EBOOT
```shell
make EBOOT.PBP
```

or using cmake
```shell
mkdir build && cd build
psp-cmake -DBUILD_PRX=1 -DENC_PRX=1 .. && make
cmake -DCMAKE_TOOLCHAIN_FILE="${PSPDEV}/psp/share/pspdev.cmake" -B build
cmake --build build
```