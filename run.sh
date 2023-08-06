gcc main.c -O3 -o build -lSDL2
function handler(){
    rm build
}
trap handler SIGINT
./build
rm build
