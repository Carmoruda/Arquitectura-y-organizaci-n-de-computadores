        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        org $8000               ; Programa ubicado a partir de $8000 = 32768

begin:          di              ; Deshabilitar interrupciones
                ld sp,0         ; Establecer el puntero de pila en la parte alta de la memoria
                ld hl, $5800     ; En el primer cuadrado de la pantalla. 
                ld a, 0

;-------------------------------------------------------------------------------------------------

main:

                ld  b, %00100000 ; Verde
                ld (hl), b       ; Hacer el cuadrado rojo 
                inc a  ; inc a   
                cp 32            ; if (a != 32)fk
                inc hl
                jr nz, main       

;-------------------------------------------------------------------------------------------------
endofcode:            
                jr endofcode          ; Bucle infinito
