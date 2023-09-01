gcc main.c -I"/usr/include/SDL2" -O3 -o main.asm -lSDL2 -pthread -Wall -Wextra -Wpedantic -S
cat main.asm
