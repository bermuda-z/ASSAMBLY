.model tiny
    .data
posx   db      0
posy   db      0
shootpos   db      0
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
    .code
    org     0100h
main:
StartP:
    mov ah ,0h		;text mode
	mov al ,3h
	int 10h


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

    mov ah,00h
	int 16h			;read key

	cmp al,27		;exit
	je exit

    ;cmp al,13		;enter
	;je printrocket
GAMEOVER:
    mov ah ,0h		;text mode
	mov al ,3h
	int 10h


    mov bh , 0h ; get cursor
    mov ah,3h

    mov ax,cs ; set es
    mov es,ax

    mov dl,0
    mov dh,4
    mov ah,0

    mov bp,offset GameOver_S
    mov bl,13
    mov al,1
    mov cx,1999


    mov ah,13h
    int 10h

    mov ah,00h
	int 16h			;read key

	cmp al,27		;exit
	je exit

    ;cmp al,13		;enter
	;je printrocket

exit:
	ret
        end     main