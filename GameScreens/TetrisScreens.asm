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
        ; Would you like to play? (y/n)
        LD A, $39              ; Attribute - Blue font with white background
        LD B, 6                ; Row
        LD C, 16               ; Column
        LD IX, PLAYMESSAGE1    ; Would you
        CALL PRINTAT
        
        LD A, $39              ; Attribute - Blue font with white background
        LD B, 8                ; Row
        LD C, 14               ; Column
        LD IX, PLAYMESSAGE2    ; like to play
        CALL PRINTAT

        LD A, $39              ; Attribute - Blue font with white background
        LD B, 10               ; Row
        LD C, 16               ; Column
        LD IX, PLAYMESSAGE3    ; (Y/N)
        CALL PRINTAT
        
        ; Cursor
        LD HL, $5800 + 10 * 32 + 23    ; Row 10, column 23
        LD (HL), $8F

        XOR A
        CALL READYKEY
        CP 1            
        JP Z, GAMESCREEN        ; Y - Game
        JP ENDINGSCREEN         ; N - End screen
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; GAMESCREEN - Displays the game screen with its corresponding messages.
;-----------------------------------------------------------------------------------------
GAMESCREEN:
        CALL CLEARSCR   ; Clean screen.

        ; Game
        LD A, $04           ; Attribute - Green
        LD B, 2             ; Row
        LD C, 2             ; Column
        LD IX, GAMEMESSAGE  ; Game
        CALL PRINTAT
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; GAMELOOP - Game simulation.
;-----------------------------------------------------------------------------------------
GAMELOOP:
        JR GAMELOOP
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; LOADSTARTINGSCREEN_LOOP - Set values to paint the graphic.
;-----------------------------------------------------------------------------------------
LOADSTARTINGSCREEN:
        LD HL, LOADSTARTINGSCREEN_START ; HL = Starting addres of screen data

        ; Save used registers
        PUSH BC
        PUSH DE

        LD DE, $4000 ; Display to video memory area
        LD BC, 6912  ; VidkeoRAM size
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; LOADSTARTINGSCREEN_LOOP - Displays the start screen graphic.
;-----------------------------------------------------------------------------------------
LOADSTARTINGSCREEN_LOOP:
        LDI ; (DE) = (HL) , DE++, HL++, BC--

        LD A, B ; Check if BC is 0
        OR C ; BC = 0 <=> B|C=0
        JP NZ, LOADSTARTINGSCREEN_LOOP ; Next display byte

        ; Retrieve used registers
        POP DE
        POP BC

        RET
;-----------------------------------------------------------------------------------------

LOADSTARTINGSCREEN_START: INCBIN "StartingScreenTetris.scr"

;-----------------------------------------------------------------------------------------
; LOADENDINGSCREEN -  Set values to paint the graphic.
;-----------------------------------------------------------------------------------------
LOADENDINGSCREEN:
        LD HL, LOADSTARTINGSCREEN_END ; HL = Starting addres of screen data

        ; Save used registers
        PUSH BC
        PUSH DE

        LD DE, $4000 ; Display to video memory area
        LD BC, 6912  ; VidkeoRAM size
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; LOADENDINGSCREEN_LOOP - Displays the end screen graphic.
;-----------------------------------------------------------------------------------------
LOADENDINGSCREEN_LOOP:
        LDI ; (DE) = (HL) , DE++, HL++, BC--

        LD A, B ; Check if BC is 0
        OR C ; BC = 0 <=> B|C=0
        JP NZ, LOADENDINGSCREEN_LOOP ; Next display byte

        ; Retrieve used registers
        POP DE
        POP BC

        RET
;-----------------------------------------------------------------------------------------

LOADSTARTINGSCREEN_END: INCBIN "EndingScreenTetris.scr"


;-----------------------------------------------------------------------------------------
; READYKEY - Identifies whether the user presses the Y key.
;	OUT - A = 1 if Y key is pressed.
;-----------------------------------------------------------------------------------------
READYKEY:
        LD BC, $DFFE       ; Keys: Y, U, I, O, P
        IN A, (C)     
        BIT 4, A        ; Key Y
        JR NZ, READNKEY
LOOPY:
        IN A, (C)
        CP $FF
        JR NZ, LOOPY
        LD A, 1
        RET
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; READNKEY - Identifies whether the user presses the N key.
;	OUT - A = 2 if N key is pressed.
;-----------------------------------------------------------------------------------------
READNKEY:
        LD A, $7F       ; Keys: B, N, M, SYMB, SPACE
        IN A, ($FE)
        BIT 3, A        ; Key N
        JR NZ, READYKEY
LOOPN:
        IN A, (C)
        CP $FF
        JR NZ, LOOPN
        LD A, 2
        RET
        RET
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; ENDINGSCREEN - Displays the end screen with its corresponding messages.
;-----------------------------------------------------------------------------------------
ENDINGSCREEN:
        CALL CLEARSCR   ; Clean screen.

        CALL LOADENDINGSCREEN

        ; Bye!
        LD A, $3B               ; Attribute - Pink font with white background
        LD B, 4                 ; Row
        LD C, 0                 ; Column
        LD IX, BYEMESSAGE       ; Bye!
        CALL PRINTAT
        
        ; Play again? (Y/N)
        LD A, $3B               ; Attribute - Pink font with white background
        LD B, 6                 ; Row
        LD C, 0                 ; Column
        LD IX, PLAYAGAINMESSAGE ; Play again? (Y/N)
        CALL PRINTAT

        ; Cursor
        LD HL, $5800 + 6 * 32 + 17    ; Row 6, column 17
        LD (HL), $9F

        XOR A
        CALL READYKEY
        CP 1
        JP Z, STARTINGSCREEN    ; Y - Start screen 
        LD A, $3B               ; N - End of code.
        LD B, 8                 
        LD C, 11
        LD IX, ENDMESSAGE       ; End!
        CALL PRINTAT
        LD HL, $5800 + 6 * 32 + 17    ; Row 10, column 23
        LD (HL), $38

        JP ENDOFCODE
;-----------------------------------------------------------------------------------------

ENDOFCODE:            
        JR ENDOFCODE

PLAYMESSAGE1: DB "WOULD YOU ", 0
PLAYMESSAGE2: DB "LIKE TO PLAY?", 0
PLAYMESSAGE3: DB " (Y/N)", 0
BYEMESSAGE: DB "BYE!", 0
PLAYAGAINMESSAGE: DB "PLAY AGAIN? (Y/N)", 0
ENDMESSAGE: DB "END!", 0
GAMEMESSAGE: DB "GAME", 0        ; 0 = delimitador de array.

        INCLUDE "Printat.asm"