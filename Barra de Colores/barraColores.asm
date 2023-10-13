        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        org $8000               ; Programa ubicado a partir de $8000 = 32768

begin:          di              ; Deshabilitar interrupciones
                ld sp,0         ; Establecer el puntero de pila en la parte alta de la memoria
                ld hl, $5800    ; En el primer cuadrado de la pantalla. 

;-------------------------------------------------------------------------------------------------

main:
        ld c, 7 * 8     ; Color.

paintLine:
        ld b, 8
        push bc
        ld b, 4
paintColor:
        ld (hl), c              ; Pintar cuadrado del color.
        inc hl                  ; Siguiente cuadrado.
        djnz paintColor         ; Pintar 4 cuadrados
        pop bc
        push af
        ld a, c
        sub 8
        ld c, a
        pop af
        djnz paintLine          ; Pintar 1 línea

;-------------------------------------------------------------------------------------------------
endofcode:            
        jr endofcode          ; Bucle infinito
