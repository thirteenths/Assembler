PUBLIC swap

EXTERN m: byte
EXTERN n: byte
EXTERN matrix: byte

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE
swap proc near
	mov cx, 0
    mov cl, byte ptr[m]
	;mov si, 0
	mov bx, 0
	
	read_lb1:
		mov ax, cx
		mov cl, byte ptr[n]
		
		mov si, bx ; si - индекс максимума
        mov di, bx 
		
		mov dl, byte ptr[matrix + bx] ; dl - максимум
        mov dh, byte ptr[matrix + bx] ; dh - первая цифра в строке
		
		read_lb2:
			cmp byte ptr[matrix + bx], dl
			jge max_lb
			
			go_back1:
			
			inc bx
			
			;mov ah, 2
			;mov dl, " "
			;int 21h
			
			loop read_lb2
			
			
		
		mov [matrix + di], dl	
		mov [matrix + si], dh	
		
		mov cx, ax
		
		loop read_lb1
	ret
	
max_lb:
    mov dl, byte ptr[matrix + bx]
    mov si, bx
	
	;mov ah, 2
    ;add dl, '0'
	;int 21h
	;sub dl, '0'
	
	;mov ax, si

    jmp go_back1
	
swap endp

SEGCODE ENDS
END 	