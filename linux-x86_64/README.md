### Linux - x86_64

Inside container 
```bash
docker run --rm -it -v `pwd`:/workspace hldtux/bennugd2-linux64
```

Compile
```bash
bgdc $BGD2DEV/games/bgd-pacman/bgd-pacman.prg -o bgd-pacman.dcb
exit
```

Run
```bash
bgdi bgd-pacman.dcb
```

<img width="640" height="514" alt="image" src="https://github.com/user-attachments/assets/c386b52f-2656-4516-8b1b-491c611d22db" />
