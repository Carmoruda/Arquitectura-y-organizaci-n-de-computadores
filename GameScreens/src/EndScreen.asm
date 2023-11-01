;-----------------------------------------------------------------------------------------
; ENDINGSCREEN - Displays the end screen with its corresponding messages.
;-----------------------------------------------------------------------------------------
ENDINGSCREEN:
        CALL CLEARSCR   ; Clean screen.

        CALL LOADENDINGSCREEN

        ; Bye!
        LD A, $3B               ; Attribute - Pink font with white background
        LD B, 4                 ; Row
        LD C, 1                 ; Column
        LD IX, BYEMESSAGE       ; Bye!
        CALL PRINTAT
        
        ; Play again? (Y/N)
        LD A, $3B               ; Attribute - Pink font with white background
        LD B, 6                 ; Row
        LD C, 1                 ; Column
        LD IX, PLAYAGAINMESSAGE ; Play again? (Y/N)
        CALL PRINTAT

        XOR A
        CALL READYKEY
        CP 1
        JP Z, STARTINGSCREEN    ; Y - Start screen 
        LD A, $3B               ; ; N - End of code.
        LD B, 8                 
        LD C, 11
        LD IX, ENDMESSAGE       ; End!
        CALL PRINTAT

        JP ENDOFCODE
;-----------------------------------------------------------------------------------------

BYEMESSAGE: DB "BYE!", 0
PLAYAGAINMESSAGE: DB "PLAY AGAIN? (Y/N)", 0
ENDMESSAGE: DB "END!", 0