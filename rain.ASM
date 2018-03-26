	.model tiny
        .data
matx	db 		0
maty	db		0
char	db		0
taily	db		0        
		.code

        org     0100h
main:
	;text mode
	mov ah , 0h
	mov al , 3h
	int 10h

randompos:
	;readkey
	mov ah , 0h
	int 16h			

	cmp al,27		;exit
	je exit1

	;read system time
	mov ah , 0h
	int 1Ah

	mov  ax, dx
	xor  dx, dx
    mov  cx, 79    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

	mov matx , dl
	mov maty , 0h


printrandchar:
	call randchar     ;randchar

	mov dl , matx
	mov dh , maty	
	;cursor
 	mov ah, 2h
 	int 10h

	;printrandchar
	mov ah,9h
	mov cx,1
	mov bl,7h
	mov al,char
	int 10h

	;y-7
	mov dl,maty
	mov taily,dl
	sub taily , 7

	cmp taily , 0

	inc maty

	mov dl , matx
	mov dh , taily
	;cursor
 	mov ah, 2h
 	int 10h

	;printblack
	mov ah,9h
	mov cx,1
	mov bl,0h
	mov al,char
	int 10h

	cmp maty,32
	je randompos
	
	jmp printrandchar
exit1:
	jmp exit
white:
	mov bl , 0Fh

lightgrey:
	mov bl , 07h

darkgrey:
	mov bl , 08h

lightgreen:
	mov bl , 0Fh

darkgreen:
	mov bl , 02h

black:
	mov bl , 0h

randchar:
	;read system time
	mov ah , 0h
	int 1Ah

	mov  ax, dx
	xor  dx, dx
    mov  cx, 126    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

	cmp dl,char
	je randchar

	mov char , dl 
	ret	
exit:	
	ret
	end main