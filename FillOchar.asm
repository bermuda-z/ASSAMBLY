	.model tiny
	.data
	.code
	org 0100h
main:
	
	mov ah ,0h
	mov al ,3h
	int 10h

	mov dh , 0h ;y
	mov dl , 0h ;x
	mov bh , 0h

printOT:
	mov ah, 2h
	int 10h
	
	push dx
	
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h

	pop dx
	
	;printO
	mov ah,9h
	mov cx,1
	mov bl,2h
	mov al,6Fh
	int 10h
	jmp checkyT


checkyT:
	test dh,1h    
	jz evenT		;jump if even


oddT:	;right to left

	dec dl		
	cmp dl,0h
	js nextevenT
	jmp printOT


evenT:	;left to right

	inc dl		
	cmp dl,50h
	je nextoddT
	jmp printOT

nextevenT:
	inc dh
	inc dl	
	jmp printOT

nextoddT:
	cmp dh,18h
	jge clearT
	inc dh
	dec dl
	jmp printOT	
clearT:	
	mov ah,6h
	mov al,0h
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	jmp DtoT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DtoT:
	mov dh , 18h ;y
	mov dl , 4Fh ;x
	mov bh , 0h

printOD:
	mov ah, 2h
	int 10h
	
	push dx
	
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h

	pop dx
	
	;printO
	mov ah,9h
	mov cx,1
	mov bl,3h
	mov al,6Fh
	int 10h
	jmp checkyD

checkyD:
	test dh,1h    
	jz evenD		;jump if even

oddD:	
	inc dl		
	cmp dl,50h
	je nextevenD
	jmp printOD


evenD:	
	dec dl		
	cmp dl,0h
	js nextoddD
	jmp printOD

nextevenD:	
	dec dl
	dec dh
	jmp printOD

nextoddD:
	cmp dh,0h
	jle clearD
	inc dl
	dec dh
	jmp printOD	

clearD:	
	mov ah,6h
	mov al,0h
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	jmp LtoR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LtoR:
	mov dh , 18h  ;y
	mov dl , 0h ;x
	mov bh , 0h
printOL:
	mov ah, 2h
	int 10h
	
	push dx
	
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h

	pop dx
	
	mov ah,9h
	mov cx,1
	mov bl,9h
	mov al,6Fh
	int 10h
	jmp checkxL
checkxL:
	test dl,1h          
	jz evenL		
oddL:	
	inc dh		
	cmp dh,19h
	je nextevenL
	jmp printOL
evenL:	
	dec dh		
	cmp dh,0h
	js nextoddL
	jmp printOL
nextoddL:		
	inc dl
	inc dh 
	jmp printOL
nextevenL:
	cmp dl,4Fh
	jge clearL		
	inc dl
	dec dh
	jmp printOL

clearL:	
	mov ah,6h
	mov al,0h
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	jmp RtoL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RtoL:
	mov dh , 0h  ;y
	mov dl , 4Fh ;x
	mov bh , 0h
printOR:
	mov ah, 2h
	int 10h
	
	push dx	
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	pop dx

	mov ah,9h
	mov cx,1
	mov bl,1h
	mov al,6Fh
	int 10h
	jmp checkxR
checkxR:
	test dl,1h          
	jz evenR	
oddR:	
	inc dh		
	cmp dh,19h
	je nextevenR
	jmp printOR
evenR:	
	dec dh		
	cmp dh,0h
	js nextoddR
	jmp printOR
nextoddR:
	cmp dl,0h
	jle exit	
	dec dl
	dec dh 
	jmp printOR
nextevenR:		
	dec dl
	dec dh
	jmp printOR
exit:	
	mov ah,6h
	mov al,0h
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h

	ret
	end main
