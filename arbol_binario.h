#ifndef ARBOL_BINARIO_DEF
#define ARBOL_BINARIO_DEF

struct arbol_binario
{
    int valor;
    struct arbol_binario *izq;
    struct arbol_binario *der;
};

#endif