        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        org $8000               ; Program located at $8000 = 32768.

BEGIN:          
        DI              ; Disable interruptions.
        LD SP, 0        ; Set the stack pointer to the top of memory.
        LD HL, $5800    ; First square of the screen. 

MAIN:
        CALL CLEARSCR   ; Clean screen.

STARTINGSCREEN:
        ; Tetris!
        LD A, $41       ; Attribute - Blue
        LD B, 2         ; Row
        LD C, 2         ; Column
        LD IX, WELCOMEMESSAGE
        CALL PRINTAT
        
        ; Would you like to play? (y/n)
        LD A, $41       ; Attribute - Blue
        LD B, 4         ; Row
        LD C, 2         ; Column
        LD IX, PLAYMESSAGE
        CALL PRINTAT

READYKEY:
        LD A, $DF       ; Keys: Y, U, I, O, P
        IN A, ($FE)     ; Key: Y
        BIT 4, A
        JR NZ, READYKEY

ENDINGSCREEN:
        CALL CLEARSCR   ; Clean screen.

        ; Bye!
        LD A, $42       ; Attribute - Red
        LD B, 2         ; Row
        LD C, 2         ; Column
        LD IX, BYEMESSAGE
        CALL PRINTAT
        
        ; Would you like to play? (y/n)
        LD A, $42       ; Attribute - Red
        LD B, 4         ; Row
        LD C, 2         ; Column
        LD IX, PLAYAGAINMESSAGE
        CALL PRINTAT


ENDOFCODE:            
        JR ENDOFCODE

WELCOMEMESSAGE: DB "TETRIS!", 0
PLAYMESSAGE: DB "WOULD YOU LIKE TO PLAY? (Y/N)", 0        ; 0 = delimitador de array.
BYEMESSAGE: DB "BYE!", 0
PLAYAGAINMESSAGE: DB "PLAY AGAIN? (Y/N)", 0        ; 0 = delimitador de array.
        INCLUDE "L30.3 - printat.asm"