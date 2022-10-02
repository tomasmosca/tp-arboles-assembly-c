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
    
    // ARBOLES DE MUESTRA:
    // se crea un arbol
    nodo1 = crearHojaArbolB(3);  // creamos hoja con valor 3
    nodo2 = crearHojaArbolB(8);  // creamos hoja con valor 8
    raiz = generarArbolB(5, nodo1, nodo2); //generar arbol, se crea nodo raiz con valor 5 y se asignan las hojas anteriores a izquierda y derecha

    // se crea otro arbol
    nodo3 = crearHojaArbolB(9);
    nodo4 = crearHojaArbolB(12);
    raiz2 = generarArbolB(10, nodo3, nodo4);

    // se genera arbol con los otros dos subarboles
    raiz3 = generarArbolB(7, raiz, raiz2);

    /*
        Este es el arbol generado con el codigo de arriba:

                        7
                    /       \
                  5           10
                /   \        /  \
               3     8     9     12
    
     */

    // lo mostramos por consola:
    // imprimirArbol(raiz3)

    printf("Valor : %d\n", raiz3->valor);
    printf("Valor : %d\n", raiz3->izq->valor);
    printf("Valor : %d\n", raiz3->der->valor);

    // eliminarTodos(raiz3, 3)

    return 0;
}