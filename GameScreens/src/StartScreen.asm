        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION
        org $8000               ; Program located at $8000 = 32768.

BEGIN:          
        DI              ; Disable interruptions.
        LD SP, 0        ; Set the stack pointer to the top of memory.
        LD HL, $5800    ; First square of the screen. 

MAIN:
        CALL CLEARSCR   ; Clean screen.

;-----------------------------------------------------------------------------------------
; STARTINGSCREEN - Displays the start screen with its corresponding messages.
;-----------------------------------------------------------------------------------------
STARTINGSCREEN:
        CALL LOADSTARTINGSCREEN

        ; Tetris!
        LD A, $39               ; Attribute - Blue font with white background
        LD B, 2                 ; Row
        LD C, 2                 ; Column
        LD IX, WELCOMEMESSAGE   ; Tetris!
        CALL PRINTAT
        
        ; Would you like to play? (y/n)
        LD A, $39              ; Attribute - Blue font with white background
        LD B, 4                 ; Row
        LD C, 2                 ; Column
        LD IX, PLAYMESSAGE      ; Would you like to play? (y/n)
        CALL PRINTAT
        
        XOR A
        CALL READYKEY
        CP 1            
        JP Z, GAMESCREEN        ; Y - Game
        JR ENDINGSCREEN         ; N - End screen
;-----------------------------------------------------------------------------------------

ENDOFCODE:            
        JR ENDOFCODE

WELCOMEMESSAGE: DB "TETRIS!", 0
PLAYMESSAGE: DB "WOULD YOU LIKE TO PLAY? (Y/N)", 0

        INCLUDE "GameScreen.asm"
        INCLUDE "EndScreen.asm"
        INCLUDE "ReadKey.asm"
        INCLUDE "Printat.asm"
        INCLUDE "LoadStartingScreen.asm"
        INCLUDE "LoadEndingScreen.asm"