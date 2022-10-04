nasm -f elf -o implementacion_funciones.o implementacion_funciones.asm
gcc -m32 -o ejecutar main.c implementacion_funciones.o
./ejecutar