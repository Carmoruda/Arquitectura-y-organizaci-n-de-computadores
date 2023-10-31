GAMESCREEN:
        CALL CLEARSCR   ; Clean screen.

        ; Bye!
        LD A, $04       ; Attribute - Green
        LD B, 2         ; Row
        LD C, 2         ; Column
        LD IX, GAMEMESSAGE
        CALL PRINTAT

GAMELOOP:
    JR GAMELOOP

GAMEMESSAGE: DB "GAME", 0        ; 0 = delimitador de array.
