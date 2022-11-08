;прямоугольная цифровая
;поменять местами первый элемент каждой
;строки с максимальным

EXTERN tab: near
EXTERN input_matrix: near
EXTERN newline: near
EXTERN output_matrix: near
EXTERN swap: near

PUBLIC m
PUBLIC n
PUBLIC matrix

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
    m             db 1; строки
    n             db 1; столбцы

    matrix        db 81 DUP ("0")
SEGDATA ENDS


SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA, SS:STK
main:
	mov ax, SEGDATA
    mov ds, ax

    mov ah, 1
    int 21h
    mov m, al
    sub m, '0'
	
	call tab
	
	mov ah, 1
    int 21h
    mov n, al
    sub n, '0'
	
	call newline
	
	call input_matrix
	
	call newline
	
	call swap
	
	call output_matrix
	
	mov ax, 4c00h
    int 21h
	
SEGCODE ENDS
END main