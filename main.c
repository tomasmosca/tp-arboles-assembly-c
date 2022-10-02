#include <stdio.h>
#include <stdlib.h>
#include "arbol_binario.h"

struct arbol_binario *generarArbolB(int valor, struct arbol_binario *izq, struct arbol_binario *der);
struct arbol_binario *crearHojaArbolB(int valor);
struct arbol_binario buscarMin(struct arbol_binario *arbol);
void eliminarTodos(struct arbol_binario *arbol, int valor);

int main(int argc, char **argv)
{
    struct arbol_binario *raiz;
    struct arbol_binario *raiz2;
    struct arbol_binario *raiz3;
    struct arbol_binario *nodo1;
    struct arbol_binario *nodo2;
    struct arbol_binario *nodo3;
    struct arbol_binario *nodo4;
    struct arbol_binario *nodo5;
    struct arbol_binario *nodo6;

    /*

        *nodo1 = crearHojaArbolB(8);   // Crear hoja
        *nodo2 = crearHojaArbolB(3);   // Crear hoja
        *raiz = generarArbolB(5, *nodo2, *nodo1);    // generar arbol, se crea nodo raiz con valor 5 y se asignan hojas anteriores a izq y der

                        7
                    /       \
                  5           10
                /   \        /  \
               3     8     9     12
    
     */

    nodo1 = crearHojaArbolB(3);
    nodo2 = crearHojaArbolB(8);

    raiz = generarArbolB(5, nodo1, nodo2);

    nodo3 = crearHojaArbolB(9);
    nodo4 = crearHojaArbolB(12);

    raiz2 = generarArbolB(10, nodo3, nodo4);

    raiz3 = generarArbolB(7, raiz, raiz2);

    printf("Valor : %d\n", raiz3->valor);
    printf("Valor : %d\n", raiz3->izq->valor);
    printf("Valor : %d\n", raiz3->der->valor);

    return 0;
}