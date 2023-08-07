gcc main.c -I"/usr/include/SDL2" -O3 -o build -lSDL2
function handler(){
    rm build
}
trap handler SIGINT
./build
rm build
