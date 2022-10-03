global generarArbolB
global crearHojaArbolB
global buscarMin
global eliminarTodos
extern malloc
extern free

CMAIN:

section .text

    crearHojaArbolB:

        ; prologo de la funcion
        push ebp
        mov ebp, esp

        ; guardo valor pasado por parametro en ebx (lo busco en la pila)
        mov ebx, [ebp + 8]  ; valor

        ; salto a funcion nodoHoja
        jmp nodoHoja

    nodoHoja:
        ; apilo 12 en el stack lo cual sera el tamaño del nodo, luego llamo a malloc y se "desapila" el tamaño pasado
        push 12
        call malloc
        add esp, 4

        ; si eax no cambio, es porque no se reservo la memoria
        cmp eax, 0
        je fin

        ; se crea el nodo hoja
        mov [eax], ebx          ; valor pasado por parametro
        mov DWORD[eax + 4], 0   ; nodo izquierda en null
        mov DWORD[eax + 8], 0   ; nodo derecha en null

        jmp fin

    generarArbolB:
        
        ; prologo de la funcion
        push ebp
        mov ebp, esp

        ;guardo los valores pasado por parametro (valor entero, nodo izquierda y nodo derecha)
        mov ebx, [ebp + 8]  ; valor
        mov esi, [ebp + 12] ; izq
        mov edi, [ebp + 16] ; der

        ; salto a la funcion nodoComun la cual es la opuesta a nodoHoja y crea un nodo y se le asigna izquierda y derecha pasados por parametro
        jmp nodoComun

    nodoComun:

        ; apilo 12 en el stack lo cual sera el tamaño del nodo, luego llamo a malloc y se "desapila" el tamaño pasado
        push 12
        call malloc
        add esp, 4

        ; si eax no cambio, es porque no se reservo la memoria
        cmp eax, 0
        je fin

        ; se crea el nodo con izquierda y derecha, y valor. los tres fueron pasados por parametro
        mov [eax], ebx           ; valor
        mov DWORD[eax + 4], esi  ; nuevo nodo izq
        mov DWORD[eax + 8], edi  ; nuevo nodo der

        jmp fin


    ;-------------------------------------------------------------------

   ; ---- encontrar el nodo a buscar ----

    eliminarTodos:
        push ebp ;guardo base point
        mov ebp, esp ;el nuevo base point es lo que esta en stack point
        mov edx, [ebp+12] ;guardo en edx el valor del parametro
        mov ebx, [ebp+8] ;puntero al nodo
        CMP ebx, 0 ;si es cero es que no hay nodo
        JE fin ;se termina porque el nodo no se encuentra en el arbol

        ;CMP edx, [ebx] ;comparo el valor del parametro con el valor del nodo actual
        call nodoDerEliminar ;si es mayor me muevo al nodo derecho
        call nodoIzqEliminar ;si es menor me muevo al nodo izquierdo
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
        call borrarAB
        add esp, 4 ;desapilo
        JMP fin


    ;  ---- eliminar todo el subarbol ----

    borrarAB:

        ;push ebp ;guardo base point
        ;mov ebp, esp ;el nuevo base point es lo que esta en stack point
        ;mov esi, [ebp +8] ;puntero del nodo
        ;CMP esi, 0 ;comparo para saber si existe nodo

        CMP edx, 0 ;testear porque en teoria no era necesario guardar el bp en otro registro(no me acuerdo que registro quedo XD)
        call eliminarSubarbol
        ;mov [ebp +4], 0 hay que testear
        ;mov [ebp +8], 0 hay que testear

        jmp fin

    eliminarSubarbol:;hay que cambiar esi que creo que no es necesario cambiar el registro
        push esi ;guardo el nodo actual
        mov ecx, [esi +4] ;nodo izq --> eax
        push ecx
        call borrarAB
        add esp, 4 ;desapilo nodo izquierdo
        pop esi


        push esi
        mov ecx, [esi +8] ;nodo derecho --> eax
        push ecx
        call borrarAB
        add esp, 4 ;desapilo nodo derecho
        pop esi

        push esi
        call free
        pop esi
        mov DWORD[ebp + 8], 0
        mov esi, 0
        
        JMP fin


;-------------------------------------------------------------------

    buscarMin:
        ; pongo en edx un nodo temporal (edx sera el que contenga el nodo minimo en todo momento)
        push ebp
        mov ebp, esp
        mov edx, [ebp + 8]
        mov esp, ebp
        pop ebp
    
    busquedaMin:
        ; prologo de la funcion (apilo base point, luego base point contendra la direccion de stack point)
        push ebp 
        mov ebp, esp 

        ; guardo nodo pasado por parametro en ebx (lo busco en la pila)
        mov ebx, [ebp +8]

        CMP ebx, 0         ; Si es cero es que el nodo es null
        JNE buscarIzq      ; si es null, termina y no entra en buscarIzq

        jmp fin

    buscarIzq:
        ; guardo valor de nodo actual en ecx, lo meto en la pila
        mov ecx, [ebx]
        push ebx
        
        mov eax, [ebx+4]    ;guardo el nodo de la izquierda
        push eax            ; apilo el nodo

        call cambioMin      ; en esta funcion se modifica el minimo actual, edx
        call busquedaMin    ; llamado recursivo
        add esp, 4          ;desapilo nodo izquierdo
        pop ebx             ;desapilo , y pongo direccion en ebx

        jmp buscarDer       ; ahora, se busca en nodo derecho

        JMP fin

    buscarDer:
        ; guardo valor de nodo actual en ecx, lo meto en la pila
        mov ecx, [ebx]
        push ebx

        mov eax, [ebx+8]        ;guardo el nodo de la derecha
        push eax                ; apilo el nodo

        call cambioMin          ; en esta funcion se modifica el minimo actual, edx
        call busquedaMin        ; llamado recursivo
        add esp, 4              ;desapilo nodo izquierdo
        pop ebx                 ;desapilo , y pongo direccion en ebx

        mov eax, edx            ; muevo edx (conteniendo nodo minimo) a eax para devolverlo por la 
                                ; funcion (EAX es lo que se retorna al finalizar la funcion)

        JMP fin

    cambioMin:
        ; prologo funcion
        push ebp
        mov ebp, esp

        ; checkeo que eax (el nodo) no sea null antes de cambiar los registros
        cmp eax, 0
        je fin              ; si es, fin

        CMP [eax], ecx          ; comparo que el valor del nodo min con el nodo actual
        JL primeraComparacion         ; si es menor, lo cambio
        
        cmp ecx, [eax]      ; misma comparacion, pero al revez para evitar cierto problema
        jl segundaComparacion

        JMP fin             ; retorno
        
    primeraComparacion:
        ; se checkea que [eax] no sea mayor a [edx] antes de modificarlo
        mov esi, [edx]
        cmp [eax], esi
        jg fin
        mov edx, eax       ; muevo el nodo actual al nodo min (edx)
        jmp fin
    
    segundaComparacion:
        ; se checkea que ecx (nodo actual) no sea mayor a [edx] antes de modificarlo
        cmp ecx, [edx]
        jg fin
        
        mov edx, ebx       ; muevo el nodo actual al nodo min (edx)
        jmp fin

;-------------------------------------------------------------------

    fin:
        ; fin de una funcion, esp vuelve a la posicion de antes (ebp), se desapila ebp y se retorna a la direccion
        mov esp, ebp
        pop ebp
        ret


    
