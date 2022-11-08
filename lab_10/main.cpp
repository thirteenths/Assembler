#include <iostream>
#include <ctime>
using namespace std;

#define ENDL "\n\t"
#define OK 0

float dot_product_asm(float *a, float *b, int count)
{
    float result = 0;
    int size = 4;

    asm(".intel_syntax noprefix" ENDL 
        "xorps xmm0, xmm0" ENDL // xmm0 - result
        "mov edi, %2" ENDL // edi - a
        "mov esi,  %3" ENDL // esi - b
        "xor edx, edx" ENDL // edx - index
        "mov ecx, %4" ENDL
    "L2:" ENDL
        "movss xmm4, dword ptr[edi + edx]" ENDL
        "mulss xmm4, dword ptr[esi + edx]" ENDL
        "add edx, %1" ENDL // edx += 4
        "addss xmm0, xmm4" ENDL
        "loop L2" ENDL
        "movss %0, xmm0" ENDL

        : "=m" (result)
        : "m"(size), "m"(a), "m"(b), "m"(count)
    :);
    return result;
}

float dot_product_asm_fun()
{
    float result = 0;
    int size = 4;
    float a[] = {1, 3, 5, 6};
    float b[] = {1, 3, 5, 6};

    asm(".intel_syntax noprefix" ENDL 
        "movups  xmm0, %0" ENDL
        "movups  xmm1, %1" ENDL
        "mulps xmm0, xmm1" ENDL

        "movups  %0, xmm0" ENDL

        //"movhlps xmm0, xmm1" ENDL
        //"addps xmm0, xmm1" ENDL

        //"xorps xmm7, xmm7" ENDL
        //"PEXTRW xmm7, xmm0, 0" ENDL

        //"xorps xmm6, xmm6" ENDL
        //"add"
        
        : 
        : "m"(a), "m"(b)
        :);
    //cout << "prois: " << a[0] << endl;
    //cout << "prois: " << a[1] << endl;
    //cout << "prois: " << a[2] << endl;
    //cout << "prois: " << a[3] << endl;
    return a[0] + a[1] + a[2] + a[3];
}

float dot_product_cpp(float *a, float *b, int count)
{
    float result = 0;
    for (int i = 0; i < count ; i++)
    {
        result += a[i] * b[i];
    }
    return result;
}

void input_vector(float *a, int n)
{
    for (int i = 0; i < n; i++)
    {
        cin >> a[i];
    }
}

void output_vector(float *a, int n)
{
    for (int i = 0; i < n; i++)
    {
        cout << a[i] << " ";
    }
}

int main()
{
    float a[10], b[10];
    int n = 0;
    cout << "Input n: ";
    cin >> n;
    cout << "Input vector a: ";
    input_vector(a, n);
    cout << "Input vector b: ";
    input_vector(b, n);
    dot_product_asm_fun();
    float result = dot_product_asm_fun();
    cout << "Dot product: " << result;

    double start_time, end_time;

    /*start_time = clock();
    for (int i = 0; i < 100000000; i++)
        dot_product_asm(a, b, n);
    end_time = clock();

    cout << endl << "ASM time: " << end_time - start_time << endl;

    start_time = clock();
    for (int i = 0; i < 100000000; i++)
        dot_product_cpp(a, b, n);
    end_time = clock();

    cout << endl << "C++ time: " << end_time - start_time << endl;*/

    return OK;
}