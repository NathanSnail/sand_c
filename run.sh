gcc main.c -o build -lGL -lglut
function handler(){
    rm build
}
trap handler SIGINT
./build
rm build
