PUBLIC tab
PUBLIC input_matrix
PUBLIC output_matrix
PUBLIC newline

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA
	
tab proc near
    mov ah, 2
    mov dl, " "
    int 21h

    ret
tab endp

newline proc near
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret
newline endp

input_matrix proc near
	mov cx, 0
    mov cl, byte ptr[m]
	
	mov si, 0
	
	read_lb1:
	
		mov bx, cx
		mov cl, byte ptr[n]
		
		read_lb2:
			mov ah, 1
			int 21h
			sub al, '0'
			mov matrix[si], al
			
			inc si
				
			call tab
			loop read_lb2
			
		call newline
		mov cx, bx
		
		loop read_lb1
	
	ret
input_matrix endp

output_matrix proc near
	mov cx, 0
    mov cl, byte ptr[m]
	
	mov si, 0	
	
	read_lb1:
	
		mov bx, cx
		mov cl, byte ptr[n]
		
		read_lb2:
			mov ah, 2
			mov dl, matrix[si]		
			add dl, '0'
			int 21h
			
			inc si
				
			call tab
			loop read_lb2
			
		call newline
		mov cx, bx
		
		loop read_lb1
	ret
output_matrix endp

SEGCODE ENDS
END