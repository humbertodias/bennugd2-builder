### Linux - x86_64

Inside container 
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-linux64
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