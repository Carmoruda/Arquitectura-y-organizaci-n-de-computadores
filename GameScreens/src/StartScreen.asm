        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION
        org $8000               ; Program located at $8000 = 32768.

ASCII_Y equ $59
ASCII_N equ $4E

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
        XOR A
        CALL READYKEY
        CP 1
        JP Z, GAMESCREEN
        JR ENDINGSCREEN

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
        XOR A
        CALL READYKEY
        CP 1
        JR Z, STARTINGSCREEN
        LD B, 6         ; Row
        LD C, 2         ; Column
        LD IX, ENDMESSAGE
        CALL PRINTAT
        LD IX, ENDMESSAGE
        CALL PRINTAT
        JR ENDOFCODE

READYKEY:
        LD A, $DF       ; Keys: Y, U, I, O, P
        IN A, ($FE)     
        BIT 4, A
        JR NZ, READNKEY
        LD A, 1
        RET
READNKEY:
        LD A, $7F       ; Keys: B, N, M, SYMB, SPACE
        IN A, ($FE)
        BIT 3, A
        JR NZ, READYKEY
        LD A, 2
        RET

WELCOMEMESSAGE: DB "TETRIS!", 0
PLAYMESSAGE: DB "WOULD YOU LIKE TO PLAY? (Y/N)", 0        ; 0 = delimitador de array.
BYEMESSAGE: DB "BYE!", 0
PLAYAGAINMESSAGE: DB "PLAY AGAIN? (Y/N)", 0        ; 0 = delimitador de array.
ENDMESSAGE: DB "END!", 0


        INCLUDE "GameScreen.asm"
        INCLUDE "EndScreen.asm"
        INCLUDE "Printat.asm"