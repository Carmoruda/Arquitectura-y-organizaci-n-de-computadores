;-----------------------------------------------------------------------------------------
; ENDINGSCREEN - Displays the end screen with its corresponding messages.
;-----------------------------------------------------------------------------------------
ENDINGSCREEN:
        CALL CLEARSCR   ; Clean screen.

        ; Bye!
        LD A, $42               ; Attribute - Red
        LD B, 2                 ; Row
        LD C, 2                 ; Column
        LD IX, BYEMESSAGE       ; Bye!
        CALL PRINTAT
        
        ; Play again? (Y/N)
        LD A, $42               ; Attribute - Red
        LD B, 4                 ; Row
        LD C, 2                 ; Column
        LD IX, PLAYAGAINMESSAGE ; Play again? (Y/N)
        CALL PRINTAT

        XOR A
        CALL READYKEY
        CP 1
        JP Z, STARTINGSCREEN    ; Y - Start screen                        
        LD B, 6                 ; N - End of code.
        LD C, 2
        LD IX, ENDMESSAGE       ; End!
        CALL PRINTAT

        JP ENDOFCODE
;-----------------------------------------------------------------------------------------

BYEMESSAGE: DB "BYE!", 0
PLAYAGAINMESSAGE: DB "PLAY AGAIN? (Y/N)", 0
ENDMESSAGE: DB "END!", 0