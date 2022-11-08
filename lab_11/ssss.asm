.486
.model flat, stdcall
option casemap :none
 
        include \masm32\include\windows.inc
 
        include \masm32\include\user32.inc
        include \masm32\include\kernel32.inc
        include \masm32\include\masm32.inc
 
        includelib \masm32\lib\user32.lib
        includelib \masm32\lib\kernel32.lib
        includelib \masm32\lib\masm32.lib
.data
        X               dq      ?
        Y               dq      ?
        Result          dq      ?
 
        aszPromptX      db      0Dh, 0Ah, 'Enter the X: ', 0
        aszPromptY      db      0Dh, 0Ah, 'Enter the Y: ', 0
        aszMsgResult    db      0Dh, 0Ah, 'Result: ', 0
        aszPressEnter   db      0Dh, 0Ah, 0Dh, 0Ah, "Press ENTER to exit", 0
        hConsoleOutput  HANDLE  ?
        hConsoleInput   HANDLE  ?
        Buffer          db      1024 dup(?)
        BufLen          dd      ?
.code
 
start:
 
        ; получение описателей ввода и вывода консоли
        invoke  GetStdHandle,   STD_INPUT_HANDLE
        mov     hConsoleInput,  eax
 
        invoke  GetStdHandle,   STD_OUTPUT_HANDLE
        mov     hConsoleOutput, eax
 
        invoke  ClearScreen


        ;ввод X
        invoke  WriteConsole, hConsoleOutput, ADDR aszPromptX,\
                LENGTHOF aszPromptX - 1, ADDR BufLen, NULL
        invoke  ReadConsole, hConsoleInput, ADDR Buffer,\
                LENGTHOF Buffer, ADDR BufLen, NULL
        lea     esi,    [Buffer]        ;удаление символов
        add     esi,    [BufLen]        ;перевода строки
        sub     esi,    2               ;из буфера ввода
        mov     [esi], word ptr 0
        ;finit
        invoke  StrToFloat, ADDR Buffer, ADDR X


        ;ввод Y
        invoke  WriteConsole, hConsoleOutput, ADDR aszPromptY,\
                LENGTHOF aszPromptY - 1, ADDR BufLen, NULL
        invoke  ReadConsole, hConsoleInput, ADDR Buffer,\
                LENGTHOF Buffer, ADDR BufLen, NULL
        lea     esi,    [Buffer]        ;удаление символов
        add     esi,    [BufLen]        ;перевода строки
        sub     esi,    2               ;из буфера ввода
        mov     [esi], word ptr 0
        ;finit
        invoke  StrToFloat, ADDR Buffer, ADDR Y
 
        finit
        fld     [X]
        fld     [Y]
        faddp   st(1),  st(0)
        ;сохранение результата
        fstp    [Result]
        ;очистка FPU
        finit
        ;вывод результата
        ; - установка позиции
        ;invoke  SetConsoleCursorPosition, hConsoleOutput, dword ptr [dwCursorPosition]
        ; - вывод
        invoke  WriteConsole, hConsoleOutput, ADDR aszMsgResult,\
                LENGTHOF aszMsgResult - 1, ADDR BufLen, NULL
        invoke  FloatToStr2, [Result], ADDR Buffer
        invoke  StrLen, ADDR Buffer
        mov     [BufLen],       eax
        invoke  WriteConsole, hConsoleOutput, ADDR Buffer,\
                BufLen, ADDR BufLen, NULL
 
        ;ожидание нажатия ENTER
        invoke  WriteConsole, hConsoleOutput, ADDR aszPressEnter,\
                LENGTHOF aszPressEnter - 1, ADDR BufLen, NULL
        invoke  ReadConsole, hConsoleInput, ADDR Buffer,\
                LENGTHOF Buffer, ADDR BufLen, NULL
 
        invoke  ExitProcess, 0
 
end start