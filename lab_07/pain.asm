
.model tiny
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE
    ORG 100h

main:	
	jmp init
	bad_old          DD 0
	is_installed DB 1
	timer        DB 0
	speed 		 DB 00h
    inst_msg     DB 'Programm installed!$'
    unins_msg    DB 'Programm uninstalled!$'

new_speed proc
	pushf           
	call cs:bad_old ; вызов старого обработчика прерываний
	
	cmp timer, 0;
	jne output
	
	push ax
	push bx
	push cx
	push dx
	push ds
	push es
	push si
	
	mov al, speed
	cmp al, 1Fh
	jae reset_speed

	inc al
	jmp change_value
	
	reset_speed:
		mov al, 0h
	
	change_value:
		mov speed, al
		
		mov al, 0F3h ; отвечает за параметры режима автоповтора нажатой клавиши
		out 60h, al
		
		mov al, speed
		out 60h, al
	
	mov al, speed
	mov ah, 0F3h
	mov bx, ax


	pop si
	pop es
	pop ds
	pop dx
	pop cx
	pop bx
	pop ax
	
	output:
		inc timer
		cmp timer, 18
		jna quit
		mov timer, 0
	
	quit:
		iret

new_speed endp
end_change_speed:


init:
    mov ax, 3508h ; установка обработчика прерываний
	int 21h
	
	cmp es:is_installed, 1
	je reset
	
	mov word ptr bad_old,  bx ; Сохраняем смещение обработчика.
	mov word ptr bad_old + 2,  es  ; Сохраняем сегмент обработчика.

	; 25H: установить вектор прерывания
    ; AH = 25H
    ; AL = номер прерывания
    ; DS:DX = вектор прерывания: адрес программы обработки прерывания
    ; ds - и так указывает на нужный нам сегмент
    ; В ds помещаем смещение нашего обработчика 

	mov ax,  2508h
	lea dx, new_speed
	int 21h
	
    lea dx, inst_msg
    mov ah, 09h
    int 21h
	
    ; В DX требуется загрузить смещение команды, 
    ; начиная с которой фрагмент
    ; Программы может быть удалён из памяти.
    ; Т.е. адрес за резидентным участком программы.

	mov ax, 3100h
	mov dx, (end_change_speed - main + 10Fh) / 16 ; количество параграфоф, которое нужно оставить в памяти
	
	int 21h


reset:

	push ds
	push es

	mov dx, word ptr es:bad_old
    mov ds, word ptr es:bad_old + 2
 

	mov ax, 2508h
    int 21h
	
	pop ds
	pop es

    lea dx, unins_msg
    mov ah, 09h
    int 21h

    mov ax, 4C00h
    int 21h
	


CODE ends
end main
