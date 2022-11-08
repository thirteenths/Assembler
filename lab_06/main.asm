;ввод - знаковое в 10 с/с 
;вывод - 1 беззнаковое в 16 с/с 
;вывод - 2 знаковое в 2 с/с

EXTRN newline: near

EXTRN input_number: near
EXTRN output_sign_dec: near
EXTRN output_unsign_dec: near
EXTRN output_unsign_hex: near
EXTRN output_sign_bin: near

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (?)
STK ENDS

SEGDATA SEGMENT PARA PUBLIC 'DATA'
;menu
    menu	db "1. Enter number"
			db 10
            db 13
            db "2. Print signed number"
            db 10
            db 13
            db "3. Print unsigned number" 
            db 10
            db 13
            db "4. Print unsigned hexadecimal"
            db 10
            db 13
            db "5. Print signed binary"
            db 10
            db 13
            db "6. Exit" 
            db 10
            db 13
            db "Enter action: $"

    func_ptr     dw 6 DUP (0)
SEGDATA ENDS


SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK
main:
	mov ax, SEGDATA
    mov ds, ax

    mov func_ptr[0], input_number
    mov func_ptr[2], output_sign_dec
    mov func_ptr[4], output_unsign_dec
    mov func_ptr[6], output_unsign_hex
    mov func_ptr[8], output_sign_bin
    mov func_ptr[10], exit
	
	chose:
        mov ah, 9
        mov dx, 0
        int 21h

        mov ah, 1
        int 21h

        mov ah, 0
        sub al, "1"
        mov dl, 2
        mul dl
        mov bx, ax

        call newline
        call func_ptr[bx]
        call newline
    jmp chose
	
exit proc near
    mov ax, 4c00h
    int 21h
exit endp

SEGCODE ENDS
END MAIN