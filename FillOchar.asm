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

checkyT:	; row(y) odd or even?
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
	cmp dh,18h		; compare row(y) is greater than or equal 24	
	jge clearT		; jump to clearscreen if row(y)	is greater than or equal 24	
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
	
	; printO
	mov ah,9h		; set to write character mode
	mov cx,1		; print 1 character
	mov bl,3h		; set color of character
	mov al,6Fh		; set character 'o'
	int 10h
	jmp checkyD

checkyD:	; row(y) odd or even?
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
	; set start position
	mov dh , 18h  ;row(y) is 24 (0 - 24)
	mov dl , 0h ;column(x) is 0 (0 - 79)
	mov bh , 0h
printOL:
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
	mov bl,9h		; set color of character
	mov al,6Fh		; set character 'o'
	int 10h
	jmp checkxL
	
checkxL:	; column is odd or even?
	test dl,1h          
	jz evenL		; jump if column(x) is even		
oddL:		; column(x) is odd		
	inc dh			; increase one row(y)	
	cmp dh,19h		; compare row(y) is equal 24
	je nextevenL		; jump to newlineeven if row(y) is equal 24
	jmp printOL		; jump to printing 'o'
evenL:		; column(x) is even	
	dec dh			; decrease one row(y)		
	cmp dh,0h		; compare row(y) is less than 0 
	js nextoddL		; jump to newlineodd if row(y) less than 0
	jmp printOL		; jump to printing 'o'
nextoddL:	; newline is odd		
	inc dl			; increase one column(x)
	inc dh			; increase one row(y)
	jmp printOL		; jump to printing 'o'
nextevenL:	; newline is even
	cmp dl,4Fh		; compare column(x) is greater than or equal 80
	jge clearL		; jump to clearscreen if column(x) is greater than or equal 80	
	inc dl			; increase one column(x)
	dec dh			; decrease one row(y)
	jmp printOL		; jump to printing 'o'

clearL:		; clearscreen
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h
	jmp RtoL
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RtoL:
	; set start position 
	mov dh , 0h  ; row(y) is 0 (0 - 24)
	mov dl , 4Fh ; column(x) is 79 (0 - 79)
	mov bh , 0h
	
printOR:
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
	mov bl,1h		; set color of character
	mov al,6Fh		; set character 'o'
	int 10h
	jmp checkxR
	
checkxR:	; column is odd or even?
	test dl,1h          
	jz evenR		; jump if column(x) is even
oddR:		; column(x) is odd	
	inc dh			; increase one row(y)	
	cmp dh,19h		; compare row(y) is equal 24
	je nextevenR		; jump to newlineeven if row(y) is equal 24	
	jmp printOR		; jump to printing 'o'
evenR:		; column(x) is even
	dec dh			; decrease one row(y)	
	cmp dh,0h		; compare row(y) is less than 0
	js nextoddR		; jump to newlineodd if row(y) is less than 0
	jmp printOR		; jump to printing 'o'
nextoddR:	; newline is odd
	cmp dl,0h		; compare column(x) is less than or equal 0
	jle exit		; jump to exit and clearscreen if column(x) is less than or equal 0
	dec dl			; decrease one column(x)
	dec dh			; decrease one row(y)
	jmp printOR		; jump to printing 'o'
nextevenR:	; newline is even		
	dec dl			; decrease one column(x)
	dec dh			; decrease one row(y)
	jmp printOR		; jump to printing 'o'
exit:		; exit and clearscreen	
	mov ah,6h
	mov al,0h		; clear whole screen
	mov bh,7h
	mov cx,0h
	mov dx,184fh
	int 10h

	ret
	end main
