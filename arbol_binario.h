#ifndef ARBOL_BINARIO_DEF
#define ARBOL_BINARIO_DEF

struct arbol_binario
{
    struct arbol_binario *izq;
    struct arbol_binario *der;
    int valor;
};

#endif