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

Build nro
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-switch
build-nro.sh $BGD2DEV/games/bgd-pacman/bgd-pacman.prg
```
Install nxlink
```bash
sudo dkp-pacman -S switch-dev
```

Install nro
```bash
nxlink -a x.x.x.x bgd-pacman.nro
```