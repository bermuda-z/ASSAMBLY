          .model  tiny

.data
          randChar  db   93       ; variable of randomed character
          pos       db  80 dup(0) ; array to keep head position 
                                  ; line in each column
          seed      db  ?         ; var use for random

          .code
          org     0100h

main:
          mov   ah, 0h
          int   1ah      ; get system time

          mov   ax, dx
          xor   dx, dx
          mov   cx, 90   ; get random number by divide system time --
          div   cx       
          mov   si, 79


prepare:                          ; loop through pos and generate pseudo random number
          mov   dl, seed          
          mov   pos[si], dl

          ; random number with equation seed = (3 * seed + 13) % 43

          mov   dl, 3         ; multipiler
          mov   al, seed
          mul   dl            ; ax = al * dl
          add   ax, 13
          mov   dl, 43        ; divider
          div   dl            ; remainder = ax % dl
          mov   seed, ah

          dec   si
          cmp   si, 0
          jge   prepare

          ;  set display mode to text mode
          mov   ah, 0h
          mov   al, 3h
          int   10h

          ; set initial value for cursor position
          mov   dh, 0h  ; row (y)
          mov   dl, 0h  ; column (x)
          mov   bh, 0h

printChar:  ; move cursor to desired position and print randomed character --
            ; with color releate to cursor position and head of matrix line --
            ; position

          ; move cursor
          mov   ah,  2h
          int    10h

          push  dx     ; use dl (column) as index subscript --
          mov   dh, 0  ; to see if current cursor's row should --
          mov   si, dx ; print coloured character or not
          pop   dx

          mov   bl, pos[si]
          sub   bl, dh      ; if (current row - head position of matrix line)
          
	  cmp	bl, 0	    ; if less than or equal 0, print black char
	  jle    printBlack 

	  cmp   bl, 1       ; is equal 1 then we should print light white
          je    printLightWhite	

          cmp   bl, 4       ; if far from head in 4 char, print light green
          jl    printLightGreen

          cmp   bl, 8       ; if far from head in 8 char, print green
          jl    printGreen

	  cmp	bl, 9	    ; if far from head in 9 char, print white
	  jl    printWhite

          cmp   bl, 10      ; if far from head in 10 char, print gray
          jl    printGray

	  ;else not in range , print black char
printBlack:
          mov   bl, 00000000b  ; set attribute black color for character
          jmp   output

printWhite:
          mov   bl, 00000111b  ; set attribute white color for character
          jmp   output

printLightWhite:
          mov   bl, 00001111b  ; set attribute light white color for character
          jmp   output

printLightGreen:
          mov   bl, 00001010b  ; set attribute light green color for character
          jmp   output

printGreen:
          mov   bl, 00000010b  ; set attribute green color for character
          jmp   output

printGray:
          mov   bl, 00001000b  ; set attribute gray color for character


output:
          ; print random character
          mov   ah, 9h        ; set to write character mode
          mov   cx, 1         ; print 1 character
          mov   al, randChar  ; set desired character the one that we randomed
          int   10h

          call  randNewChar   ; random new character

          inc    dl           ; increase cursor column index (move cursor to the right)
          cmp    dl, 50h      ; check if cursor is still in screen
          je    newline      ; if cursor is not in screen, go to newline
          jmp    printChar    ; else continue printing random character

newline:
          mov   dl, 0h        ; move cursor to left edge of screen
          cmp   dh, 18h       ; check if we're on line index 24
          je   tolinezero    ; if yes (means we exceed screen border) move to first line
          inc   dh            ; else just increase row
          jmp   printChar     ; go back and print random character

tolinezero:
          push  dx            ;  push current cursor position to stack

          ; wait with 45000 microsecs
          mov   ah, 86h
          mov   cx, 0000h
          mov   dx, 0AFC8h
          int   15h

          pop   dx      ;  pop current cursor position from stack back
          mov   dh, 0h  ; set row to row index 0

          mov   si, 0   ;initial loop variable

incArrayLoop:
          inc   pos[si]      ; increase head of column #si
          cmp   pos[si], 43  ; see if it exceed 43
          jl    notExceedScreen ; if not, just continue
          mov   pos[si], 0   ; else reset it to 0

notExceedScreen:
          inc   si            ; increase loop var
          cmp   si, 80        ; if loop var exceed 80 then break
          jne   incArrayLoop  ; else just contiue loop

          jmp   printChar     ; after go to line zero and increase all head --
                              ; go print like we used to do~



randNewChar:  ; using pseudo random number generator
              ; random character with equation (32*seed + 4) % 93
          push  ax
          push  dx

          mov   dl, 32        ; multipiler
          mov   al, randChar
          mul   dl            ; ax = al * dl
          add   ax, 4
          mov   dl, 93        ; divider by 93 (126-33)
          div   dl            ; remainder = ax % dl
          mov   randChar, ah
          add   randChar, 33  ; make it back in range

          pop   dx
          pop   ax
          ret


exit:
          ret
          end     main