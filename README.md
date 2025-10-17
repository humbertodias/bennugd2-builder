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
Install nxlink (if needed)
```bash
sudo dkp-pacman -S switch-dev
```

Install nro
```bash
nxlink -a x.x.x.x bgd-pacman.nro
```

<img width="1392" height="860" alt="image" src="https://github.com/user-attachments/assets/0a37b1ea-4b9e-4459-9bf8-b6b59bdce69b" />
