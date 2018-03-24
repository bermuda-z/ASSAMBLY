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
	mov dl ,barx
	mov dh ,bary

  ;cursor
	mov ah, 2h
	int 10h

	push dx
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx

	;printbar
	mov ah,9h
	mov cx,1
	mov bl,33h
	mov al,3h
	int 10h	
	inc barx
	cmp barx , 46h
	jle printbar

printheart:
	mov dl ,barx
	mov dh ,bary
  ;cursor
	mov ah, 2h
	int 10h
	push dx
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx
	;printheart
	mov ah,9h
	mov cx,1
	mov bl,3Ch
	mov al,3h
	int 10h
	inc barx
	cmp barx , 4Fh
	jle printheart

printrocket:	
	;printrocket
	call print
	mov shooty , 16h
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
	je shootbullet

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

shootbullet:
  cmp shooty , 0h
  jl printrocket
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
