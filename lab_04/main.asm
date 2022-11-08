;в которой ввести в переменную последовательность строчных
;латинских букв и затем вывести с новой строки заглавный вариант 3-й
;буквы.

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

SD1 segment para public 'DATA'
	buf    db 100 
	len    db 0
	string db 100 dup("$")
SD1 ENDS

cseg segment para public 'CODE'
	assume ss:STK, cs:cseg, ds:SD1
new_line:
	mov ah, 2
	mov dl, 13
	int 21h
	mov dl, 10
	int 21h
	ret
input:
	mov dx, offset buf
	mov ah, 0Ah
	int 21h
	ret
output:
	mov dl, byte ptr[string + 2]
	sub dl, 'a'
	add dl, 'A'
	mov ah, 2
	int 21h
	ret
main:
	mov ax, SD1
	mov ds, ax
	call input
	call new_line
	call output
	mov ax, 4c00h
	int 21h	
cseg ends
end main