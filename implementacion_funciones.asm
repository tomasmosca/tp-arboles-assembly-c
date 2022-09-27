global crearArbolB
global buscarMin
global eliminarTodos
extern _malloc
extern _free
section .text

crearArbolB:
    push ebp ;guardo base point
    mov ebp, esp ;el nuevo base point es lo que esta en stack point
    mov edx, [ebp+12] ;guardo en edx el valor del parametro
    mov ebx, [ebp+8] ;puntero al nodo
    CMP ebx, 0 ;si es cero es que no hay nodo
    JE agregoNodo ;se reserva memoria y se guarda el valor
    CMP edx, [ebx] ;comparo el valor del parametro con el valor del nodo
    JE fin 
    JG nodo_derecha ;si es mayor se guarda en el nodo derecho
    JMP nodo_izq ;si es menor se guarda en el nodo izquierdo

    agregarNodo:
    push edx
    push 12
    call _malloc ;asigna un bloque de memoria de bytes
    add esp, 4
    pop edx
    mov [eax], eax ;guardo el valor
    mov ebx, 0
    mov [eax+4], ebx ;nodo en cero 
    mov [eax+8], ebx ;nodo en cero
    mov [ebp+4] ;eax
    JMP fin

    nodo_izq:
    push edx ;valor del parametro
    mov eax, [ebx+4] ;guardo el nodo de la izquierda 
    push eax 
    call crearArbolB
    mov ebx, [ebp + 8] ;apunta al nodo actual
    mov [ebx + 4], eax ;nodo nuevo
    mov eax, ebx;
    add esp, 8 ;desapilo lo que apile  
    JMP fin

    nodo_derecha:
    push edx ;valor del parametro
    mov eax, [ebx+8] ;guardo el nodo de la derecha 
    push eax 
    call crearArbolB
    mov ebx, [ebp + 8] ;apunta al nodo actual
    mov [ebx + 8], eax ;nodo nuevo
    mov eax, ebx;
    add esp, 8 ;desapilo lo que apile  
    JMP fin

;-------------------------------------------------------------------

    eliminarTodos:
    push ebp ;guardo base point
    mov ebp, esp ;el nuevo base point es lo que esta en stack point
    mov edx, [ebp+12] ;guardo en edx el valor del parametro
    mov ebx, [ebp+8] ;puntero al nodo
    CMP ebx, 0 ;si es cero es que no hay nodo
    JE fin ;se termina porque el nodo no se encuentra en el arbol
    CMP edx, [ebx] ;comparo el valor del parametro con el valor del nodo
    JG nodoDerEliminar ;si es mayor me muevo al nodo derecho
    JL nodoIzqEliminar ;si es menor me muevo al nodo izquierdo
    JMP valorNodo ;se encontro el nodo que tiene el valor del parametro

    nodo_izq:
    push edx ;valor del parametro
    mov eax, [ebx+4] ;guardo el nodo de la izquierda 
    push eax 
    call eliminarTodos
    mov ebx, [ebp + 8] ;apunta al nodo actual
    mov [ebx + 4], eax ;nodo nuevo
    mov eax, ebx;
    add esp, 8 ;desapilo lo que apile  
    JMP fin
    
    nodoDerEliminar:
    push edx ;valor del parametro
    mov eax, [ebx+8] ;guardo el nodo de la derecha 
    push eax 
    call eliminarTodos
    mov ebx, [ebp + 8] ;apunta al nodo actual
    mov [ebx + 8], eax ;nodo nuevo
    mov eax, ebx;
    add esp, 8 ;desapilo lo que apile  
    JMP fin

    valorNodo:
    push ebx ;guardo el puntero en donde esta el valor buscado
    call eliminarSubarbol
    add esp, 4 ;desapilo
    JMP fin

    eliminarSubarbol:
    push ebp ;guardo base point
    mov ebp, esp ;el nuevo base point es lo que esta en stack point
    mov ebx, [ebp +8] ;puntero del nodo
    CMP ebx, 0 ;comparo para saber si existe nodo
    JE fin
    push ebx ;guardo el nodo actual
    mov eax, [ebx +4] ;nodo izq --> eax
    push eax
    call eliminarSubarbol
    add esp, 4 ;desapilo nodo izquierdo
    pop ebx
    push ebx
    mov eax, [ebx +8] ;nodo derecho --> eax
    push eax
    call eliminarSubarbol
    add esp, 4 ;desapilo nodo derecho
    pop ebx
    push ebx
    call _free
    add esp, 4 ;desapilo
    JMP fin

;-------------------------------------------------------------------

    buscarMin:


    fin:
    mov esp, ebp
    pop ebp
    ret
