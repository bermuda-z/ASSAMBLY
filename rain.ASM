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

input:
	;readkey
	mov ah , 1h
	int 16h	

	jz randompos	

	cmp al,27		;exit
	je exit1

	xor ax,ax
	int 16h

randompos:
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
	;white
	call randchar     ;randchar	
	mov dh , maty
	mov bl,0fh
	call printchar


	mov dl,maty
	mov taily,dl
	sub taily , 1

	;lightgreen
	call randchar     ;randchar
	mov dh , taily
	mov bl , 0Ah
	call printchar
	jmp printcolor
exit1:
	jmp exit
input1:
	jmp input	
printcolor:

	;Darkgreen
	call randchar     ;randchar
	sub taily , 2
	mov dh , taily
	mov bl , 02h
	call printchar

	;Darkgrey
	call randchar     ;randchar
	sub taily , 1
	mov dh , taily
	mov bl , 08h
	call printchar

	;black
	call randchar     ;randchar
	sub taily , 1
	mov dh , taily
	mov bl , 0h
	call printchar

	inc maty
	cmp maty,30
	je input1
	
	jmp printrandchar

printchar:
	
	mov dl , matx
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
	
	ret
	end main