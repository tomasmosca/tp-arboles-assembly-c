#include <stdio.h>
#include <stdlib.h>
#include "arbol_binario.h"

struct arbol_binario *generarArbolB(int valor, struct arbol_binario *izq, struct arbol_binario *der);
struct arbol_binario *crearHojaArbolB(int valor);
struct arbol_binario *buscarMin(struct arbol_binario *arbol);
void eliminarTodos(struct arbol_binario *arbol, int valor);

void imprimirArbolPreorden(struct arbol_binario *arbol) {
    if (arbol == NULL)
        return;
 
    /* primer print */
    printf("%d ", arbol->valor);
 
    /* recursion izquierdo */
    imprimirArbolPreorden(arbol->izq);
 
    /* recursion derecho */
    imprimirArbolPreorden(arbol->der);
}

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
    nodo1 = crearHojaArbolB(1);  // creamos hoja con valor 1
    nodo2 = crearHojaArbolB(6);  // creamos hoja con valor 6
    raiz = generarArbolB(3, nodo1, nodo2); //generar arbol, se crea nodo raiz con valor 3 y se asignan las hojas anteriores a izquierda y derecha
    
    // se crea otro arbol
    nodo3 = crearHojaArbolB(9);
    nodo4 = crearHojaArbolB(14);
    raiz2 = generarArbolB(10, nodo3, nodo4);

    // se genera arbol con los otros dos subarboles
    raiz3 = generarArbolB(8, raiz, raiz2);

    /*
        Este es el arbol generado con el codigo de arriba:

                        8
                    /       \
                  3           10
                /   \        /  \
               1     6     9     14
    
     */
 
    // lo mostramos por consola en forma preorden:
    printf("Recorrido preorden del arbol: ");
    imprimirArbolPreorden(raiz3);
    printf("%s", "\n");

    // elimino el nodo 6 y sus subarboles
    printf("Elimino el nodo 6 y sus subarboles: \n");
    eliminarTodos(raiz3, 6);

    //muestro arbol con nodo eliminado
    imprimirArbolPreorden(raiz3);
    printf("%s", "\n");

    // busco el valor minimo en el arbol
    printf("Se busca el nodo minimo en el arbol: \n");
    struct arbol_binario *min = buscarMin(raiz3);

    // lo muestro por consola
    printf("Nodo minimo: %d\n ", min->valor);

    return 0;
}