        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Program located at $8000 = 32768.

BEGIN:          
        DI              ; Disable interruptions.
        LD SP, 0        ; Set the stack pointer to the top of memory.
        LD HL, $5800    ; First square of the screen. 

MAIN:
        LD A, $81       ; Atribute
        LD B, 4         ; Row
        LD C, 5         ; Column
        LD IX, MESSAGEWRITE
        CALL PRINTAT

ENDOFCODE:            
        JR ENDOFCODE

MESSAGEWRITE: DB "Hola Mundo", 0        ; 0 = Array delimiter
        INCLUDE "L30.3 - printat.asm"
