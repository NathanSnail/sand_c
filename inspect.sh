gcc main.c -I"/usr/include/SDL2" -O3 -o build.asm -lSDL2 -pthread -Wall -Wextra -Wpedantic -S
cat build.asm
