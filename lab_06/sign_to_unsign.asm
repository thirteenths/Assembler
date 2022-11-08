EXTERN sign_number: word
EXTERN unsign_number: word

PUBLIC sign_to_unsign

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE
sign_to_unsign proc near
		
	mov ax, sign_number
	shl ax, 1
	jnc plus
	shr ax, 1
	not ax 
	add ax, 1
	
	go_back_5:
	mov unsign_number, ax
	ret
plus:
	shr ax, 1
	jmp go_back_5
sign_to_unsign endp		
	
SEGCODE ENDS
END	