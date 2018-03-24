        .model  tiny
        .data
posx   db      0
posy   db      0
barx   db      0
bary   db      0
shootx   db      0
shooty   db      0
        .code
        org     0100h
main:
	mov ah ,0h		;text mode
	mov al ,3h
	int 10h

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
exit:
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h

	ret
    end     main
