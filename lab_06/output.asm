EXTERN sign_number: word
EXTERN unsign_number: word

PUBLIC output_sign_dec
PUBLIC output_unsign_dec
PUBLIC output_unsign_hex
PUBLIC output_sign_bin

PUBLIC newline

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE
output_sign_dec proc near
	mov ax, sign_number
	
	rol ax, 1
	jc minus_dec
	
	push ax
	mov ah, 2
	mov dl, '+'
	int 21h
	pop ax
	
	go_back_1:
	
	shr ax, 1
	
	call output_dec
	
	ret
minus_dec:	
	push ax
	mov ah, 2
	mov dl, '-'
	int 21h
	pop ax
	jmp go_back_1
output_sign_dec endp	

output_unsign_dec proc near
	mov ax, unsign_number
	
	call output_dec
	
	ret
output_unsign_dec endp

output_dec:
	mov cx, 1
	mov si, 0
	mov di, 10
	
	to_string:
		xor dx, dx
		
		div di
		
	    push dx
		mov cx, ax
		inc si
		inc cx
		loop to_string
	
	mov cx, si
	
	print_dec:
		pop dx
		add dl, '0'
		mov ah, 2
		int 21h
		loop print_dec
	ret	

output_sign_bin proc near
	mov ax, sign_number
	
	shl ax, 1
	jc minus_bin
	
	push ax
	mov ah, 2
	mov dl, '+'
	int 21h
	pop ax
	
	go_back_3:
	shr ax, 1

	mov cx, 1
	mov si, 0
	
	to_sign_bin:
		shr ax, 1
		jc one
		
		mov dx, '0'
		push dx
		go_back_2:
		
		mov cx, ax
		inc cx
		inc si
		loop to_sign_bin
	
	mov cx, si
	print_sign_bin:
		pop dx
		mov ah, 2
		int 21h
		loop print_sign_bin
	ret
one:
	mov dx, '1'
	push dx
	jmp go_back_2

minus_bin:
	push ax
	mov ah, 2
	mov dl, '-'
	int 21h
	pop ax
	jmp go_back_3	
	
output_sign_bin endp	

output_unsign_hex proc near	
	xor cx, cx
	mov cl, 4
	xor dx, dx
	
	mov ax, unsign_number
	shl al, cl
	shr al, cl
	call to_hex_digit
	mov dl, al
	push dx
			
	mov ax, unsign_number
	shr al, cl
	call to_hex_digit	
	mov dl, al
	push dx
	
	mov ax, unsign_number
	shl ah, cl
	shr ah, cl
	mov al, ah
	call to_hex_digit
	mov dl, al
	push dx
	
	mov ax, unsign_number
	shr ah, cl
	mov al, ah
	call to_hex_digit
	mov dl, al
	push dx
	
	mov ah, 2
	print_unsign_hex:
		pop dx
		int 21h
		loop print_unsign_hex
	
	ret
	
to_hex_digit:
    add al,'0'              
    cmp al,'9'              
    jle thd_end             
    add al,7                	
thd_end:
    ret 
	
output_unsign_hex endp
	
newline proc near
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret		
newline endp
	
SEGCODE ENDS
END