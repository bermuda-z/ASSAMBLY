        .model  tiny
        .data
posx   db      0
posy   db      0
shootpos   db      0
        .code
        org     0100h
main:

	mov ah ,0h		;text mode
	mov al ,3h
	int 10h

	mov dh , 18h ;y
	mov dl , 28h ;x
	mov bh , 0h

  mov shootpos , dh                ;shoot
  mov posx , dl               ;rocket
  mov posy , dh               ;rocket

printrocket:
  mov dh , posy
  mov dl , posx
	;cursor
	mov ah, 2h
	int 10h

	push dx
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx

	;printrocket
	mov ah,9h
	mov cx,1
	mov bl,12
	mov al,3h
	int 10h

	mov ah,00h
	int 16h			;read key

	cmp al,27		;exit
	je exit

	cmp ax,4D00h		;right
	je printright

	cmp ax,4B00h		;left
	je printleft

	cmp ax,4800h		;up
	je shootbullet

	jmp printrocket

printleft:

	;printrocketblack
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,3h
	int 10h

	cmp posx,0h
	je printrocket

	dec posx
	jmp printrocket

printright:

	;printrocketblack
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,3h
	int 10h

	cmp posx,4Fh
	je printrocket

	inc posx
	jmp printrocket

shootbullet:
	cmp shootpos,0h
	je printrocket
	dec shootpos

  mov dh,shootpos
	;cursor
	mov ah, 2h
	int 10h
	push dx
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx

	;printbullet
	mov ah,9h
	mov cx,1
	mov bl,0eh
	mov al,23
	int 10h

	jmp shootbullet

exit:
	ret
        end     main
