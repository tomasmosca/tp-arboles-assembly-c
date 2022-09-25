global crearArbolB
global buscarMin
global eliminarTodos
extern _malloc
section .text

crearArbolB:
    push ebp ;guardo base point
    mov ebp, esp ;el nuevo base point es lo que esta en stack point
    mov edx, [ebp+12] ;guardo en edx el valor del parametro
    mov ebx, [ebp] ;puntero al nodo
    CMP ebx, 0 ;si es cero es que no hay nodo
    JE agregoNodo ;se reserva memoria y se guarda el valor
    CMP edx, [ebx] ;comparo el valor del parametro con el valor del nodo
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


    fin:
    mov esp, ebp
    pop ebp
    ret
;Implementacion metodos