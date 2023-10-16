        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Program located at $8000 = 32768.

BEGIN:          
        DI              ; Disable interruptions.
        LD SP, 0        ; Set the stack pointer to the top of memory.
        LD HL, $5800    ; First square of the screen. 
MAIN:
        LD C, 0         ; Initial color (black).
PAINTLINE:
        LD B, 4         ; Counter PAINTCOLOR.
PAINTCOLOR:
        LD (HL), C              ; Paint color square.
        INC HL                  ; Next square.
        DJNZ PAINTCOLOR         ; For (i = 4, i > 0, i--)
CHANGECOLOR:
        LD A, C
        ADD 8                   ; Change to next color.
        AND %00111000           ; Keep just the paper color.
        LD C, A
        LD A, H
        CP $5B                  
        JR NZ, PAINTLINE     ; while (HL != $5B00)

ENDOFCODE:            
        JR ENDOFCODE
