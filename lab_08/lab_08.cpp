
/*первая принимает 1 параметр - указатель на строку, определяет длину строки и
выполнена в виде ассемблерной вставки;*/


/*вторая копирует строку с адреса, заданного одним указателем, по адресу,
заданному другим указателем, и реализована в отдельном asm - файле.Функция
должна принимать 3 параметра: два указателя и длину строки.Прорасположение указателей в памяти и расстояние между ними заранее ничего не
известно(первая строка может начинаться раньше второй или наоборот; строки
    могут перекрываться).*/


/*Подпрограммы должны соответствовать соглашению о вызовах языка Си и
использовать команды обработки строк с префиксом повторения.*/


#include <iostream>

using namespace std;

extern "C"
    void copy_str(char *first, char *second, int len);

int main()
{
    int i;

    char input_string_2[100];
    char input_string_3[100];

    cout << "Input string :";
    cin >> input_string_2;

    __asm {
        mov ecx, 0FFFFFFFFh
        mov al, '\0'
        lea edi, input_string_2
        repne scasb//сканируем строку байтов, пока не встретится 0
        not ecx
        mov i, ecx
        dec i;
    }

    cout << endl << "Lengh of sring :" << i << endl;

    //cout << strlen(input_string_2) << endl;

    //cout << endl << input_string_2 << endl;

    copy_str(input_string_2, input_string_3, i);

    cout << endl << input_string_3 << endl;

    copy_str(input_string_2, input_string_2 + 5, i);


    cout << endl << "Copy string: " << input_string_2 + 5 << endl;

    
    
    return 0;
}

