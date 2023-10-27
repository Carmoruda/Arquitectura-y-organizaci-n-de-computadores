        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        org $8000               ; Program located at $8000 = 32768.

BEGIN:          
        DI              ; Disable interruptions.
        LD SP, 0        ; Set the stack pointer to the top of memory.
        LD HL, $5800    ; First square of the screen. 

MAIN:

ENDOFCODE:            
        JR ENDOFCODE