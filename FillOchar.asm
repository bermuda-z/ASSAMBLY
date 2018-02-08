	.model tiny
	.data
	.code
	org 0100h
main:
	; set display textmode 
	mov ah ,0h
	mov al ,3h
	int 10h
	
	; set start position 
	mov dh , 0h ;row(y) is 0 (0 - 24)
	mov dl , 0h ;column(x) is 0 (0 - 79)
	mov bh , 0h

printOT:
	; move cursor
	mov ah, 2h
	int 10h
	
	; push current cursor position to stack
	push dx
	
	; delay 1000 ms
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h
	; pop current cursor position to stack
	pop dx
	
	; printO
	mov ah,9h		; set to write character mode
	mov cx,1		; print 1 character
	mov bl,2h		; set color of character
	mov al,6Fh		; set character 'o'
	int 10h
	jmp checkyT


checkyT:	; odd or even?
	test dh,1h    		
	jz evenT		; jump if row(y) is even	


oddT:		; row(y) is odd
	dec dl			; decrease one column(x)
	cmp dl,0h		; compare column(x) is less than 0
	js nextevenT		; jump to newlineeven if column(x) is less than 0
	jmp printOT		; jump to printing 'o'


evenT:		; row(y) is even
	inc dl			; increase one column(x)
	cmp dl,50h		; compare column(x) is equal 80
	je nextoddT		; jump to newlineodd if column(x) is equal 80
	jmp printOT		; jump to printing 'o'

nextevenT:	; newline is even
	inc dh			; increase one row(y)
	inc dl			; increase one column(x)	
	jmp printOT		; jump to printing 'o'

nextoddT:	; newline is odd
	cmp dh,18h		; compare row(y) is greater or equal 24	
	jge clearT		; jump to clearscreen if row(y)	is greater or equal 24	
	inc dh			; increase one row(y)
	dec dl			; decrease one column(x)
	jmp printOT		; jump to printing 'o'
clearT:		; clearscreen
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	jmp DtoT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DtoT:	
	; set start position
	mov dh , 18h ;row(y) is 24 (0 - 24)
	mov dl , 4Fh ;column(x) is 79 (0 - 79)
	mov bh , 0h

printOD:
	; move cursor
	mov ah, 2h
	int 10h
	
	; push current cursor position to stack
	push dx
	
	; delay 1000 ms
	mov ah,86h
	mov cx,0000h
	mov dx,2710h
	int 15h

	; pop current cursor position to stack
	pop dx
	
	;printO
	mov ah,9h		; set to write character mode
	mov cx,1		; print 1 character
	mov bl,3h		; set color of character
	mov al,6Fh		; set character 'o'
	int 10h
	jmp checkyD

checkyD:	; odd or even?
	test dh,1h    
	jz evenD		; jump if row(y) is even

oddD:		; row(y) is odd	
	inc dl			; increase one column(x)
	cmp dl,50h		; compare column(x) is equal 80
	je nextevenD		; jump to newlineeven if column(x) is equal 80
	jmp printOD		; jump to printing 'o'


evenD:		; row(y) is even
	dec dl			; decrease one column(x)
	cmp dl,0h		; compare column(x) is less than 0 
	js nextoddD		; jump to newlineodd if column(x) less than 0
	jmp printOD		; jump to printing 'o'

nextevenD:	; newline is even	
	dec dl			; decrease one column(x)
	dec dh			; decrease one row(y)
	jmp printOD		; jump to printing 'o'

nextoddD:	; newline is odd
	cmp dh,0h		; compare row(y) is less than or equal 0
	jle clearD		; jump to clearscreen if row(y)	is less than or equal 0
	inc dl			; increase one column(x)
	dec dh			; decrease one row(y)
	jmp printOD		; jump to printing 'o'

clearD:		; clearscreen
	mov ah,6h		
	mov al,0h		; clear whole screen
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
