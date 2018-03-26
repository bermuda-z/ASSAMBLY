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
	mov bl,0fh	
	call printchar

	;y-7
	mov dl,maty
	mov taily,dl
	sub taily , 2

	inc maty

	mov bl , 07h
	mov dl , matx
	mov dh , taily
	;cursor
 	mov ah, 2h
 	int 10h
	;printblack
	mov ah,9h
	mov cx,1
	mov al,char
	int 10h

	cmp maty,25
	je randompos
	
	jmp printrandchar
exit1:
	jmp exit

darkgrey:
	mov bl , 08h

lightgreen:
	mov bl , 0Fh

darkgreen:
	mov bl , 02h

printchar:
	;cursor
 	mov ah, 2h
 	int 10h
	;print
	mov ah,9h
	mov cx,1
	mov al,char
	int 10h
	ret
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
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	
	ret
	end main