PUBLIC input_number

PUBLIC sign_number
PUBLIC unsign_number

EXTERN newline: near
EXTERN sign_to_unsign: near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    max_size   		db 8
    len        		db 0
    input_str       db 8 DUP ("$")
	
	sign_number     dw 0
	unsign_number   dw 0
	
    ent_msg  db "Enter number (with sign): $"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA
input_number proc near	
	call clean_data
	
	mov ah, 9
    mov dx, offset ent_msg
    int 21h
	
	mov ah, 0AH
    mov dx, offset max_size
    int 21h
	
	call newline
	
	xor cx, cx
	mov cl, len
	dec cl
	mov si, 1
	mov ax, 0
	mov di, 2
	xor bx, bx
	
	to_number:
		mov bl, input_str[si]
		sub bl, '0'
		inc si
		
		push bx
		;push ax
		
		shl ax, 1
		push ax
		
		shl ax, di
		
		pop bx
		
		add ax, bx
		
		pop bx
		
		;mul di
		
		
		loop to_number
		
	mov bl, input_str[0]
	cmp bl, '-'
	je minus	
	go_back_2:
		
	mov sign_number, ax	
	call sign_to_unsign

	ret	
minus:
	add ax, 8000h
	jmp go_back_2
	
input_number endp

clean_data:
	mov cx, 8
	mov si, 0
	clean_d:
		mov input_str[si], '$'
		inc si
		loop clean_d
	ret	

SEGCODE ENDS
END