### Linux - i386

Inside container
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-linux32
```

Compile
````bash
bgdc $BGD2DEV/games/bgd-pacman/bgd-pacman.prg -o bgd-pacman.dcb
exit
```

Run
```bash
bgdi bgd-pacman.dcb
```