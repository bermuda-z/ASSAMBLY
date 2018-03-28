  .model  tiny
        .data
posx   db      0
posy   db      0
barx   db      0
bary   db      0
shootx   db      0
shooty   db      0
i db 0
line_1S db''
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '     _    _  _____ _____ __   _____ _   _      _____ _____  _   _  _____        '
db '     | \ / | |   |   |  |  \    |    \ /       |     |   | | \ / | |            '
db '     |     | |___|   |  |__/    |     \        |  __ |___| |     | |____        '
db '     |     | |   |   |  |  \    |    / \       |   | |   | |     | |            '
db '     |     | |   |   |  |   \ __|__ /   \____  |___| |   | |     | |____        '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '    ======================================================================      '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                         Press >>> Start (Enter)                                '
db '                                                                                '
db '                           Press >>  Exit (ESC)                                 '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                                                                                '
db '                                                                               $'


GameOver_S db ''
db '********************************************************************************'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*      _________________________________________________________________       *'
db '*     |   _____  ____  _    _  ______     ______  _     _ _____  __     |      *'
db '*     |  |       |   | | \ / | |         |      |  |   /  |     |  \    |      *'
db '*     |  |    __ |___| |     | |_____    |      |  |  /   |____ |__/    |      *'
db '*     |  |     | |   | |     | |         |      |  | /    |     |  \    |      *'
db '*     |  |_____| |   | |     | |_____    |______|  |/     |____ |   \   |      *'
db '*     |_________________________________________________________________|      *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*                             SCORE :                                          *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*                                                                              *'
db '*     PLAY AGAIN (Enter)                                      EXIT (ESC)       *'
db '*                                                                              *'
db '*******************************************************************************'

SomeTune       dw 41, 20  ;E    ;ความถี่-เวลา
				dw 1920,200
				dw 2150,200
				dw 1920,450

				dw 2180,200
				dw 2480,200
				dw 2180,450

				dw 2390,200
				dw 2620,200
				dw 2390,450

				dw 3100,200
				dw 3400,200
				dw 3100,1500

				dw 1700,100
				dw 1650,1
				dw 1700,100
				dw 1650,1
				dw 1700,100
				dw 1650,1
				dw 1700,100

				dw 2100,10

				dw 2050,200
				dw 2400,200
				dw 2100,600


				dw  00h,00h
        .code
        org     0100h
main:
	mov ah ,0h		;text mode
	mov al ,3h
	int 10h
StartP:

    mov bh , 0h ; get cursor
    mov ah,3h

    mov ax,cs ; set es
    mov es,ax

    mov dl,0
    mov dh,4
    mov ah,0

    mov bp,offset line_1S
    mov bl,12
    mov al,1
    mov cx,1999

    mov ah,13h
    int 10h

	mov   si, offset SomeTune      ; play opening sound
    call  speakerOn              ; turn speaker on

LoopIt:
          lodsw                        ; get freq
          or    ax, ax                 ; if freq. = 0 then done
          jz    LDone
          call  freqOut
          lodsw                        ; get duration
          mov   cx, ax
          call  PauseIt
          jmp  short LoopIt

LDone:
    call  speakerOff             ; turn speaker off
    mov ah,00h
	int 16h			;read key

	cmp al,27		;exit
	je prepreexit

    cmp al,13		;enter
	je prestartgame
prestartgame:
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h	
startgame:
	mov dh , 17h ;y
	mov dl , 28h ;x
	mov bh , 0h

	mov posx , dl               ;rocket
	mov posy , dh               ;rocket

	mov barx , 0h               ;bar
	mov bary , 18h               ;bar
printbar:
	mov dl ,0h
	mov dh ,bary
    ;cursor
	mov ah, 2h
	int 10h
	;printbar
	mov ah,9h
	mov cx,71
	mov bl,33h
	mov al,3h
	int 10h	
printheart:
 	mov dl , 47h
 	mov dh ,bary
   ;cursor
 	mov ah, 2h
 	int 10h
	;printheart
	mov ah,9h
	mov cx,9
	mov bl,3Ch
	mov al,3h
	int 10h
printrocket:	
	;printrocket
	call print
	mov shooty , 16h
	dec posx
	mov dl , posx
	mov shootx , dl
	inc posx
	jmp key
prepreexit:
	jmp preexit		
key:
	;readkey
	mov ah,00h
	int 16h			

	cmp al,27		;exit
	je preexit

	cmp ax,4D00h		;right
	je printright

	cmp ax,4B00h		;left
	je printleft

	cmp ax,4800h		;up
	je shootbulletsound

	jmp printrocket
rocket:
	mov dl , posx
	sub dl , 2
	mov posx , dl
	jmp printrocket	
printleft:
	cmp posx,2h
	je key

	;printrocketblack
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,16
	int 10h
	
	mov dl , posx
	sub dl , 3
	mov posx , dl
	;dec posx
	jmp printrocket
printright:
	cmp posx,4Fh
	je key

	mov dl , posx
	sub dl , 2
	mov posx , dl

	;cursor
	mov ah, 2h
	int 10h
	;printrocketblack
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,16
	int 10h

	inc posx

	jmp printrocket

preexit:
	jmp exit
shootbulletsound:
	;sound
	mov     al, 182         ; meaning that we're about to load
    out     43h, al         ; a new countdown value

    mov     ax, 2153        ; countdown value is stored in ax. It is calculated by 
                            ; dividing 1193180 by the desired frequency (with the
                            ; number being the frequency at which the main system
                            ; oscillator runs
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al               

    in      al, 61h         
                            	   ; to connect the speaker to timer 2
    or      al, 00000011b  
    out     61h, al         	   ; Send the new value
shootbullet:
	cmp shooty , 0h
	jl rocket

	;cursor delay
	mov dh,shooty
	mov ah, 2h
	int 10h
	;printbullet
	mov ah,9h
	mov cx,1
	mov bl,0eh
	mov al,23
	int 10h

	push dx
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx
	;clearbullet
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,23
	int 10h	
	;mute
	and      al, 00000000b  
	out     61h, al         	   ; Send the new value

	dec shooty
	jmp shootbullet
print:
	mov dh , posy
 	mov dl , posx

	;cursor
	mov ah, 2h
	int 10h
	;print<
	mov ah,9h
	mov cx,1
	mov bl,12
	mov al,17
	int 10h

	inc posx 
	mov dl , posx
	;cursor
	mov ah, 2h
	int 10h
	;printface
	mov ah,9h
	mov cx,1
	mov bl,12
	mov al,1
	int 10h

	inc posx
	mov dl , posx
	;cursor
	mov ah, 2h
	int 10h

	;print>
	mov ah,9h
	mov cx,1
	mov bl,12
	mov al,16
	int 10h

	ret
speakerOn:
          in    al, 61h
          or    al, 03h
          out   61h, al
          mov   al, 0B6h
          out   43h, al
          ret

speakerOff:
          in    al, 61h
          and   al, 0FCh
          out   61h, al
          ret

freqOut:
          mov   dx, 42h                  ; port to out
          out   dx, al                   ; out low order
          xchg  ah, al
          out   dx, al
          ret

PauseIt proc
          mov   ax, 0040h
          mov   es, ax

          ; wait for it to change the first time
          mov   al, es:[006Ch]
@a:
          cmp   al, es:[006Ch]
          je   short @a

        ; wait for it to change again
loop_it:
          mov   al, es:[006Ch]

@b:
          cmp   al, es:[006Ch]
          je   short @b

          sub  cx, 110
          jns  short loop_it

          ret

PauseIt endp	
exit:
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h

	ret
    end     main