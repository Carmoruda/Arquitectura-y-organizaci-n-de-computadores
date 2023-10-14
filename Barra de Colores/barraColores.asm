        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Programa ubicado a partir de $8000 = 32768

BEGIN:          
        DI              ; Deshabilitar interrupciones
        LD SP, 0        ; Establecer el puntero de pila en la parte alta de la memoria
        LD HL, $5800    ; Primer cuadrado de la pantalla. 
MAIN:
        LD C, 0         ; Color inicial (negro).
PAINTLINE:
        LD A, 8         ; i (Contador PAINTLINE).
        LD B, 4         ; j (Contador PAINTCOLOR).
PAINTCOLOR:
        LD (HL), C              ; Pintar cuadrado del color.
        INC HL                  ; Siguiente cuadrado.
        DJNZ PAINTCOLOR
CHANGECOLOR:
        PUSH AF
        LD A, C
        ADD 8                   ; Cambiar color.
        AND %00111000           ; Solo color paper.
        LD C, A
        LD A, L
        CP $5B                  ; while (HL != $5B00)
        POP AF
        JR NZ, PAINTLINE

ENDOFCODE:            
        JR ENDOFCODE
