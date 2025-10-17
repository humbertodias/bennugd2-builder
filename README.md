# BennuGD2 Builder

Docker containers to build **BennuGD2** for multiple platforms, including Linux and Nintendo Switch.

## Usage

### Linux

* i386
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-linux32
```
* x86_64
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-linux64
```

### Switch

```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-switch
build-nro.sh game.prg
```