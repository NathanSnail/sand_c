gcc main.c -O3 -o build -lGL -lglut
function handler(){
    rm build
}
trap handler SIGINT
./build
rm build
