global generarArbolB
global crearHojaArbolB
global buscarMin
global eliminarTodos
extern malloc
extern free


CMAIN:

section .text

    crearHojaArbolB:

        push ebp
        mov ebp, esp

        mov ebx, [ebp + 8]  ; valor

        jmp nodoHoja

    nodoHoja:
        push 12
        call malloc
        add esp, 4

        cmp eax, 0
        je fin

        mov [eax], ebx
        mov DWORD[eax + 4], 0
        mov DWORD[eax + 8], 0

        jmp fin

    generarArbolB:
        
        push ebp
        mov ebp, esp

        mov ebx, [ebp + 8]  ; valor
        mov esi, [ebp + 12] ; izq
        mov edi, [ebp + 16] ; der

        jmp nodoComun

    nodoComun:

        push 12
        call malloc
        add esp, 4

        cmp eax, 0
        je fin

        mov [eax], ebx           ; valor
        mov DWORD[eax + 4], esi  ; nuevo nodo izq
        mov DWORD[eax + 8], edi  ; nuevo nodo der

        jmp fin


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

    nodoIzqEliminar:
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
    call free
    add esp, 4 ;desapilo
    JMP fin

;-------------------------------------------------------------------

    buscarMin:
    push ebp ;guardo base point
    mov ebp, esp ;el nuevo base point es lo que esta en stack point
    mov ebx, [ebp +8] ;puntero al nodo
    mov ecx, [ebx] ;guardo el valor del nodo min en ecx
    CMP ebx, 0  ; Si es cero es que el nodo es null
    JE fin      ; si es null, termina
    call buscarIzq   ; nodo izquierda
    call buscarDer   ; nodo derecha

    buscarIzq:
    mov eax, [ebx+4] ;guardo el nodo de la izquierda
    push eax
    CMP [eax], ecx  ; comparo que el valor del nodo min con el nodo actual
    JL cambioMin      ; si es menor, lo cambio
    call buscarMin
    JMP fin

    buscarDer:
    mov eax, [ebx+8] ;guardo el nodo de la derecha
    push eax
    CMP [eax], ecx ; comparo que el valor del nodo min con el nodo actual
    JL cambioMin     ; si es menor, lo cambio
    call buscarMin
    JMP fin

    cambioMin:
    mov ebx, eax       ; muevo el nodo actual al nodo min
    ;call buscarMin
    JMP fin            ; retorno

;-------------------------------------------------------------------

    fin:
        mov esp, ebp
        pop ebp
        ret


    
