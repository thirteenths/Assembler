.686
.MODEL FLAT, C
.STACK
.CODE

copy_str proc  first:dword, second:dword, len:dword

	mov ecx, len
	inc ecx

	mov esi, first
	mov edi, second

	cmp esi, edi
	je end_p
	mov eax, esi

	add eax, len 

	cmp eax, edi 
	jnb backward;

	cld
	rep movsb

	jmp end_p

backward:
	add esi, ecx
	add edi, ecx
	;inc ecx

	dec esi 
	dec edi 

	std 
	rep movsb

	jmp end_p
	
end_p:
	cld
	ret 
copy_str endp


END
